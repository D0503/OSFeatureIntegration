import {
  BreakpointStorage,
  BreakpointSystem,
  BreakpointTypeEnum,
  Constants,
  ImmersiveMaterialGuard,
  MinorsMode,
  MinorsProtectionUtils,
  NavHeaderBar,
  ShelfEditState,
  TabInfo,
  TCRouter
} from 'common';
import { UserInfo, fp2pxUtil } from 'base_common';
import { IndexData } from '../model/MainTab';
import { AppStorageV2, uiMaterial } from '@kit.ArkUI';
import { notificationManager } from '@kit.NotificationKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

@ComponentV2
export struct BookHomePage {
  @Provider('isDeleteShelf') isDeleteShelf: boolean = false;
  @Provider('currentIndexTab') currentIndexTab: number = 0;
  @Provider('tabController') tabsController: TabsController = new TabsController();
  @Provider('isHistory') isHistory: boolean = false
  @Provider('userInfo') userInfo: UserInfo | undefined = undefined;
  @Provider('isGrid') isGrid: boolean = true;
  @Provider('useImmersiveTitle') useImmersiveTitle: boolean = false;
  @Provider('homeCategoryInTitle') homeCategoryInTitle: boolean = false;
  @Provider('homeCategoryIndex') homeCategoryIndex: number = 0;
  @Provider('homeCategoryTexts') homeCategoryTexts: Resource[] = [];
  @Local curBreakpoint: BreakpointStorage = BreakpointSystem.currentBreakpoint
  @Local minorsMode: MinorsMode =
    AppStorageV2.connect(MinorsMode, 'isMinorsMode', () => new MinorsMode(MinorsProtectionUtils.getMinorsMode()))!
  @Local shelfEditState: ShelfEditState = AppStorageV2.connect(ShelfEditState, 'shelfEditState', () => new ShelfEditState())!
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;

  aboutToAppear(): void {
    MinorsProtectionUtils.createSubscriber();
    this.useImmersiveTitle = this.checkImmersiveTitleAvailable();
    let context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
    notificationManager.requestEnableNotification(context).then(() => {
      hilog.info(0x0000, 'testTag', `[ANS] requestEnableNotification success`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, 'testTag',
        `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
    });
  }

  // 沉浸光感标题栏门禁：API 26 版本保护 + 设备能力 + 应用级材质状态；
  // 任一条件不满足时保持接入前结构（hideTitleBar + 页面内自研标题栏）。
  private checkImmersiveTitleAvailable(): boolean {
    if (!ImmersiveMaterialGuard.isRuntimeApiAvailable()) {
      return false;
    }
    if (!ImmersiveMaterialGuard.isMaterialSupported()) {
      return false;
    }
    if (uiMaterial.getMaterialInfo().state === uiMaterial.MaterialState.DISABLE) {
      return false;
    }
    return true;
  }

  @Builder
  tabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      SymbolGlyph(selectedImg)
        .fontSize(fp2pxUtil(24))
        .fontColor(this.currentIndexTab === index ? [$r('app.color.font_overdue')] :
          [$r('sys.color.icon_secondary')])
      Text(title)
        .margin({ top: 4 })
        .fontSize(fp2pxUtil(10))
        .fontColor(this.currentIndexTab === index ? $r('app.color.font_overdue') : $r('app.color.tab_color_default'))
    }
    .justifyContent(FlexAlign.Center)
    .height(this.isTablet ? 100 : undefined)
    .width('100%')
    .onClick(() => {
      this.currentIndexTab = index;
      this.tabsController.changeIndex(this.currentIndexTab);
    })

  }

  @Computed
  get isTablet() {
    return BreakpointSystem.currentBreakpoint.value === BreakpointTypeEnum.LG
  }

  @Computed
  get titleHeight(): number {
    return 56 + this.windowTopHeight;
  }

  @Computed
  get currentTabLabel(): string {
    const tabs: TabInfo[] = this.minorsMode.isMinorsMode ? IndexData.MINOR_TAB : IndexData.MAIN_TAB;
    return tabs[this.currentIndexTab]?.label ?? '';
  }

  @Builder
  tabContents() {
    ForEach(this.minorsMode.isMinorsMode ? IndexData.MINOR_TAB : IndexData.MAIN_TAB, (item: TabInfo) => {
      TabContent() {
        item.component?.builder();
      }
      .tabBar(this.tabBuilder(item.label, item.index, item.activeIcon, item.defaultIcon))
    }, (item: TabInfo) => item.index.toString() + item.label)
  }

  @Builder
  mainTabs() {
    if (this.useImmersiveTitle) {
      // 沉浸光感悬浮分支：底部横向悬浮 TabBar，系统默认 THIN 材质；
      // 全断点统一 vertical(false) + BarPosition.End，悬浮栏宽由 barFloatingStyle 默认行为决定。
      Tabs({
        barPosition: BarPosition.End,
        index: this.currentIndexTab,
        controller: this.tabsController
      }) {
        this.tabContents()
      }
      .clip(false)
      .height('100%')
      .backgroundColor($r('sys.color.background_secondary'))
      .animationDuration(0)
      .scrollable(false)
      .barMode(BarMode.Fixed)
      .vertical(false)
      .barOverlap(true)
      .barHeight(this.isDeleteShelf ? 0 : 'auto')
      .barFloatingStyle({
        systemMaterial: new uiMaterial.ImmersiveMaterial({
          style: uiMaterial.ImmersiveStyle.ULTRA_THIN,
          interactive: true
        }),
        barBottomMargin: 28,
        maskColor: Color.Transparent
      })
      .onAnimationStart((targetIndex: number) => {
        this.currentIndexTab = targetIndex;
      })
    } else {
      Tabs({
        barPosition: this.curBreakpoint.value === BreakpointTypeEnum.LG ? BarPosition.Start : BarPosition.End,
        index: this.currentIndexTab,
        controller: this.tabsController
      }) {
        this.tabContents()
      }
      .clip(false)
      .height('100%')
      .backgroundColor($r('sys.color.background_secondary'))
      .padding({ bottom: 18 })
      .animationDuration(0)
      .scrollable(false)
      .barMode(this.isTablet ? BarMode.Scrollable : BarMode.Fixed)
      .vertical(this.isTablet)
      .barWidth(this.isTablet ? 96 : '100%')
      .barHeight(this.isDeleteShelf ? 0 : 'auto')
      .onAnimationStart((targetIndex: number) => {
        this.currentIndexTab = targetIndex;
      })
    }
  }

  // 沉浸光感标题栏：随一级 Tab 切换渲染对应标题栏，由 NavDestination 原生标题栏承载材质。
  // 标题内容与各页面低版本分支保持一致；书架编辑态数据经 ShelfEditState 共享。
  @Builder
  mainTitleBuilder() {
    Column() {
      if (this.currentTabLabel === '书架') {
        NavHeaderBar({
          title: !this.isDeleteShelf ? $r('app.string.book_shelf') :
            this.shelfEditState.selectedCount === 0 ? '未选择' : `已选择${this.shelfEditState.selectedCount}项`,
          hasBackButton: this.isDeleteShelf,
          hasBgColor: false,
          isMainPage: true,
          isShelf: true,
          useMaterialButton: true,
          quit: () => {
            this.shelfEditState.quitEdit();
          },
          refreshData: () => {
            this.shelfEditState.refreshShelf();
          }
        })
      } else if (this.currentTabLabel === '书城') {
        // 滚动内容切换到标题栏：分类栏滚入标题栏区域后由承接容器接替显示，
        // "首页"原标题与承接容器均固定占位（Visibility 切换），不改变标题高度与测量位置。
        Row() {
          Text(this.minorsMode.isMinorsMode ? '书城' : '首页')
            .fontColor($r('sys.color.font_primary'))
            .fontSize($r('sys.float.Title_M'))
            .fontWeight(FontWeight.Medium)
            .visibility(this.homeCategoryInTitle ? Visibility.Hidden : Visibility.Visible)
          Scroll() {
            Row({ space: 8 }) {
              ForEach(this.homeCategoryTexts, (item: ResourceStr, index: number) => {
                Text(item)
                  .textAlign(TextAlign.Center)
                  .fontSize(fp2pxUtil(14))
                  .fontColor(this.homeCategoryIndex === index ? $r('sys.color.ohos_id_color_background') :
                    $r('sys.color.font_primary'))
                  .fontWeight(FontWeight.Medium)
                  .height(32)
                  .constraintSize({ minWidth: 72 })
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(this.homeCategoryIndex === index ? $r('sys.color.multi_color_08') :
                    $r('sys.color.comp_background_tertiary'))
                  .borderRadius(16)
                  .onClick(() => {
                    this.homeCategoryIndex = index;
                  })
              }, (_item: ResourceStr, index: number) => `${this.homeCategoryTexts.length}_${index}`)
            }
          }
          .id('bookCityTitleBarSlot')
          .visibility(this.homeCategoryInTitle ? Visibility.Visible : Visibility.Hidden)
          .layoutWeight(1)
          .align(Alignment.Start)
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          Button({ type: ButtonType.Normal }) {
            SymbolGlyph($r('sys.symbol.magnifyingglass'))
              .fontSize(fp2pxUtil(24))
              .fontColor([$r('sys.color.icon_primary')])
          }
          .width(40)
          .height(40)
          .borderRadius(1000)
          .padding(8)
          .margin({ left: 8 })
          .backgroundColor($r('sys.color.comp_background_tertiary'))
          .systemMaterial(ImmersiveMaterialGuard.floatingMaterial(true, true))
          .onClick(() => {
            TCRouter.push(Constants.SEARCH_ROUTE);
          })
        }
        .width('100%')
        .height(this.titleHeight)
        .padding({ top: this.windowTopHeight + 8, left: 16, right: 12 })
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
      } else if (this.currentTabLabel === '分类') {
        NavHeaderBar({
          title: $r('app.string.book_sort'),
          hasBackButton: false,
          hasBgColor: false,
          isMainPage: true,
        })
      } else if (this.currentTabLabel === '我的') {
        Column() {
          Row() {
            Text($r('app.string.person'))
              .fontColor($r('sys.color.font_primary'))
              .fontSize(fp2pxUtil(24))
              .fontWeight(FontWeight.Medium)
            Row() {
              Button({ type: ButtonType.Normal }) {
                Stack({ alignContent: Alignment.TopEnd }) {
                  SymbolGlyph($r('sys.symbol.ellipsis_message'))
                    .fontSize(fp2pxUtil(24))
                    .fontColor([$r('sys.color.icon_primary')])
                  Row() {
                    Text('6')
                      .fontSize(10)
                      .fontColor(Color.White)
                  }
                  .justifyContent(FlexAlign.Center)
                  .width(16)
                  .height(16)
                  .borderRadius(8)
                  .backgroundColor('#E84026')
                }
              }
              .margin({ right: 8 })
              .width(40)
              .height(40)
              .borderRadius(1000)
              .padding(8)
              .backgroundColor($r('sys.color.comp_background_tertiary'))
              .systemMaterial(ImmersiveMaterialGuard.floatingMaterial(true, true))
              .onClick(() => {
                TCRouter.push(Constants.MESSAGE_PAGE_ROUTE);
              })

              Button({ type: ButtonType.Normal }) {
                SymbolGlyph($r('sys.symbol.gearshape'))
                  .fontSize(fp2pxUtil(24))
                  .fontColor([$r('sys.color.icon_primary')])
              }
              .width(40)
              .height(40)
              .borderRadius(1000)
              .padding(8)
              .backgroundColor($r('sys.color.comp_background_tertiary'))
              .systemMaterial(ImmersiveMaterialGuard.floatingMaterial(true, true))
              .onClick(() => {
                TCRouter.push(Constants.SETTING_ROUTE);
              })
            }
          }
          .height(36)
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .height(this.titleHeight)
        .padding({
          top: this.windowTopHeight + 8,
          left: 16,
          right: 16
        })
      }
    }
    .width('100%')
    .height(this.titleHeight)
  }

  build() {
    if (this.useImmersiveTitle) {
      NavDestination() {
        this.mainTabs()
      }
      .onWillShow(() => {
        if (AppStorage.has('userInfo')) {
          this.userInfo = AppStorage.get('userInfo') as UserInfo;
        }
      })
      .title({ builder: () => {
        this.mainTitleBuilder()
      }, height: this.titleHeight }, this.currentTabLabel === '分类' ? {
        // 分类页标题不接入沉浸光感：Material.empty 明确关闭材质，且不配置滚动渐变模糊；
        // 保留 STACK 布局，分类页内容避让占位保持不变。
        systemMaterial: uiMaterial.Material.empty,
        barStyle: BarStyle.STACK
      } : {
        systemMaterial: ImmersiveMaterialGuard.floatingMaterial(true, true),
        barStyle: BarStyle.STACK,
        scrollEffectOptions: {
          scrollEffectType: ScrollEffectType.GRADUAL_BLUR
        }
      })
    } else {
      NavDestination() {
        this.mainTabs()
      }
      .onWillShow(() => {
        if (AppStorage.has('userInfo')) {
          this.userInfo = AppStorage.get('userInfo') as UserInfo;
        }
      })
      .hideTitleBar(true)
    }
  }
}
