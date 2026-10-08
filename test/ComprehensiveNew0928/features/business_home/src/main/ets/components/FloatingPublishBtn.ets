import { AppStorageV2, curves, PersistenceV2, window } from '@kit.ArkUI'
import { ApplicationStateChangeCallback, common } from '@kit.AbilityKit'
import { motion } from '@kit.MultimodalAwarenessKit'
import { LoginSheetUtils } from 'lib_account'
import {
  BreakpointModel,
  BreakpointNameEnum,
  Logger,
  RouterMap,
  RouterUtils,
  TabBarType,
  TabModel,
  UserInfoModel
} from 'lib_common'

const TAG = '[FloatingPublishBtn]';

// 悬浮球贴边侧
enum BallSide {
  LEFT = 0,
  RIGHT = 1
}

// 应用前后台状态回调
class FloatingBtnAppStateCallback extends ApplicationStateChangeCallback {
  private onStateChange: (isForeground: boolean) => void;

  constructor(onStateChange: (isForeground: boolean) => void) {
    super()
    this.onStateChange = onStateChange
  }

  onApplicationForeground(): void {
    this.onStateChange(true)
  }

  onApplicationBackground(): void {
    this.onStateChange(false)
  }
}

@ComponentV2
export struct FloatingPublishBtn {
  @Local positionY: number = 0
  @Local startY: number = 0
  @Local startTop: number = 0
  @Local statusHeight: number = 0
  @Local bottomAvoidAreaHeight: number = 0
  @Local winHeight: number = 0
  @Local imageSize: number = 48
  // 智感握姿：跟手目标当前侧，初值取接入前原布局（右侧贴边）
  @Local holdingSide: BallSide = BallSide.RIGHT
  @Local breakpointModel: BreakpointModel = AppStorageV2.connect(BreakpointModel, () => new BreakpointModel())!;
  @Local userInfoModel: UserInfoModel = PersistenceV2.connect(UserInfoModel, () => new UserInfoModel())!;
  @Local tabModel: TabModel = AppStorageV2.connect(TabModel, () => new TabModel())!;

  // 感知运行状态（非渲染状态）
  private subscribed: boolean = false
  private appInForeground: boolean = true
  private isInteracting: boolean = false
  private pendingSide: BallSide | null = null

  // 稳定回调：订阅与退订使用同一实例
  private handleHoldingHandChange: Callback<motion.HoldingHandStatus> = (status: motion.HoldingHandStatus) => {
    if (!this.isSenseActive()) {
      return
    }
    if (status === motion.HoldingHandStatus.LEFT_HAND_HELD) {
      this.applyHoldingSide(BallSide.LEFT)
    } else if (status === motion.HoldingHandStatus.RIGHT_HAND_HELD) {
      this.applyHoldingSide(BallSide.RIGHT)
    }
    // NOT_HELD、BOTH_HANDS_HELD、UNKNOWN_STATUS：保持当前侧
  }

  private appStateChangeCallback: FloatingBtnAppStateCallback = new FloatingBtnAppStateCallback((isForeground) => {
    this.appInForeground = isForeground
    this.syncHoldingHandSubscription()
  })

  @Monitor('breakpointModel.currentBreakpoint')
  getNewWindowInfo() {
    this.getWindowInfo()
  }

  @Monitor('tabModel.selectedIndex', 'tabModel.indexPageShown')
  onPageVisibleChange() {
    this.syncHoldingHandSubscription()
  }

  aboutToAppear() {
    this.getWindowInfo()
    this.listenSizeChange()
    this.registerAppStateChange()
    this.syncHoldingHandSubscription()
  }

  aboutToDisappear() {
    this.unregisterAppStateChange()
    this.appInForeground = false
    this.syncHoldingHandSubscription()
  }

  private registerAppStateChange() {
    try {
      let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
      context.getApplicationContext().on('applicationStateChange', this.appStateChangeCallback)
    } catch (err) {
      Logger.error(TAG, `register applicationStateChange fail, error code: ${err.code}, error message: ${err.message}`);
    }
  }

  private unregisterAppStateChange() {
    try {
      let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
      context.getApplicationContext().off('applicationStateChange', this.appStateChangeCallback)
    } catch (err) {
      Logger.error(TAG, `unregister applicationStateChange fail, error code: ${err.code}, error message: ${err.message}`);
    }
  }

  // 仅首页Tab可见、主界面在前台且应用前台时启用感知
  private isSenseActive(): boolean {
    return this.tabModel.selectedIndex === TabBarType.HOME && this.tabModel.indexPageShown && this.appInForeground
  }

  private syncHoldingHandSubscription() {
    if (this.isSenseActive()) {
      if (this.subscribed || !canIUse('SystemCapability.MultimodalAwareness.Motion')) {
        return
      }
      try {
        motion.on('holdingHandChanged', this.handleHoldingHandChange)
        this.subscribed = true
      } catch (err) {
        // 201 权限、801 能力、31500001/31500002 服务异常：保留原路径，仅记录
        Logger.error(TAG,
          `subscribe holdingHandChanged fail, error code: ${err.code}, error message: ${err.message}`);
      }
    } else {
      // 不可见或后台：清空待应用方向，忽略迟到回调，停止感知
      this.pendingSide = null
      if (!this.subscribed) {
        return
      }
      try {
        motion.off('holdingHandChanged', this.handleHoldingHandChange)
        this.subscribed = false
      } catch (err) {
        // 退订失败保留订阅标志，避免清标志后重复订阅；下次显式生命周期清理时重试
        Logger.error(TAG,
          `unsubscribe holdingHandChanged fail, error code: ${err.code}, error message: ${err.message}`);
      }
    }
  }

  private applyHoldingSide(side: BallSide) {
    if (this.isInteracting) {
      // 按压、拖拽中不移动目标，暂存最后一个有效方向
      this.pendingSide = side
      return
    }
    if (side !== this.holdingSide) {
      this.holdingSide = side
    }
  }

  private applyPendingSideAfterInteract() {
    const side = this.pendingSide
    if (side === null) {
      return
    }
    this.pendingSide = null
    if (!this.isSenseActive()) {
      return
    }
    this.applyHoldingSide(side)
  }

  listenSizeChange() {
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    try {
      let windowClass = (context as common.UIAbilityContext).windowStage.getMainWindowSync();
      windowClass.on('windowSizeChange', () => {
        this.getWindowInfo();
      })
    } catch (err) {
      Logger.error(`listenSizeChange fail, error code: ${err.code}, error mesage: ${err.message}`);
    }
  }

  getWindowInfo() {
    // 根据断点决定按钮大小
    if (this.breakpointModel.currentBreakpoint === BreakpointNameEnum.SM) {
      this.imageSize = 48
    } else {
      this.imageSize = 68
    }
    let uiContext = this.getUIContext();
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    try {
      let windowClass = (context as common.UIAbilityContext).windowStage.getMainWindowSync();
      this.statusHeight =
        uiContext.px2vp(windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height)
      this.bottomAvoidAreaHeight =
        uiContext.px2vp(windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
          .bottomRect
          .height)
      let windowProperties = windowClass.getWindowProperties()
      this.winHeight = uiContext.px2vp(windowProperties.windowRect.height)
      this.positionY = this.winHeight * 0.8
    } catch (error) {
      Logger.error(TAG, 'getWindowInfo fail, error: ' + JSON.stringify(error));
    }
  }

  build() {
    Stack() {
      if (this.holdingSide === BallSide.LEFT) {
        this.ballContent(HorizontalAlign.Start, TransitionEdge.START)
      } else {
        this.ballContent(HorizontalAlign.End, TransitionEdge.END)
      }
    }
    .width('100%')
    .height(this.imageSize)
    .position({ x: 0, y: this.positionY })
  }

  @Builder
  ballContent(align: HorizontalAlign, edge: TransitionEdge) {
    Column() {
      Column() {
        Image($r('app.media.publish_news'))
          .width(this.imageSize)
          .height(this.imageSize)
      }
      // 贴边绕屏外换侧：退出分支沿当前侧滑出，进入分支从对侧滑入
      .transition(TransitionEffect.move(edge).animation({ curve: curves.interpolatingSpring(0, 1, 170, 17) }))
      .onClick(() => {
        if (!this.userInfoModel.isLogin) {
          LoginSheetUtils.open()
          return
        }
        RouterUtils.pushPathByName(RouterMap.NEWS_POST)
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down) {
          this.isInteracting = true
          this.startY = event.touches[0].windowY
          this.startTop = this.positionY
        }
        // 手指拖动：仅支持纵向，横向位置由握持手感知决定
        else if (event.type === TouchType.Move) {
          let touch = event.touches[0]
          let curTop = this.startTop + (touch.windowY - this.startY)
          //限制悬浮球不能移出屏幕上边
          curTop = Math.max(0, curTop)
          //限制悬浮球不能移出屏幕下边
          this.positionY =
            Math.min(this.winHeight - this.imageSize - this.bottomAvoidAreaHeight - this.statusHeight, curTop)
        } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
          this.isInteracting = false
          this.applyPendingSideAfterInteract()
        }
      })
    }
    .width('100%')
    .alignItems(align)
    .padding({
      left: this.breakpointModel.pagePadding,
      right: this.breakpointModel.pagePadding
    })
  }
}
