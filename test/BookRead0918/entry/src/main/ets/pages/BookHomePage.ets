import {
  BreakpointStorage,
  BreakpointSystem,
  BreakpointTypeEnum,
  Constants,
  MinorsMode,
  MinorsProtectionUtils,
  TabInfo
} from 'common';
import { UserInfo, fp2pxUtil } from 'base_common';
import { IndexData } from '../model/MainTab';
import { AppStorageV2, uiMaterial } from '@kit.ArkUI';
import { deviceInfo } from '@kit.BasicServicesKit';
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
  @Local curBreakpoint: BreakpointStorage = BreakpointSystem.currentBreakpoint
  @Local useFloatingTab: boolean = false;
  @Local minorsMode: MinorsMode =
    AppStorageV2.connect(MinorsMode, 'isMinorsMode', () => new MinorsMode(MinorsProtectionUtils.getMinorsMode()))!

  aboutToAppear(): void {
    if (deviceInfo.sdkApiVersion >= 26) {
      this.useFloatingTab = true;
      AppStorage.setOrCreate('useFloatingTab', true);
      const materialSupported = uiMaterial.isImmersiveMaterialSupported();
      AppStorage.setOrCreate('immersiveMaterialSupported', materialSupported);
      hilog.info(0x0000, 'ImmersiveLight',
        `[ImmersiveLight] api26 floating tab enabled, materialSupported = ${materialSupported}`);
    } else {
      this.useFloatingTab = false;
      AppStorage.setOrCreate('useFloatingTab', false);
    }
    MinorsProtectionUtils.createSubscriber();
    let context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
    notificationManager.requestEnableNotification(context).then(() => {
      hilog.info(0x0000, 'testTag', `[ANS] requestEnableNotification success`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, 'testTag',
        `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
    });
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
    .height(this.isTablet && !this.useFloatingTab ? 100 : undefined)
    .width('100%')
    .onClick(() => {
      this.currentIndexTab = index;
      this.tabsController.changeIndex(this.currentIndexTab);
    })

  }

  @Builder
  tabContents() {
    ForEach(this.minorsMode.isMinorsMode ? IndexData.MINOR_TAB : IndexData.MAIN_TAB, (item: TabInfo) => {
      TabContent() {
        item.component?.builder();
      }
      .tabBar(this.tabBuilder(item.label, item.index, item.activeIcon, item.defaultIcon))
    }, (item: TabInfo) => item.index.toString()+item.label)
  }

  @Computed
  get isTablet() {
    return BreakpointSystem.currentBreakpoint.value === BreakpointTypeEnum.LG
  }

  build() {
    NavDestination() {
      if (this.useFloatingTab) {
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
        .barHeight(this.isDeleteShelf ? 0 : 'auto')
        .vertical(false)
        .barOverlap(true)
        .barFloatingStyle({
          barBottomMargin: Constants.FLOATING_TAB_BOTTOM_MARGIN,
          adaptToHandedness: true
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
    .onWillShow(() => {
      if (AppStorage.has('userInfo')) {
        this.userInfo = AppStorage.get('userInfo') as UserInfo;
      }
    })
    .hideTitleBar(true)
  }
}