import { HomePage } from 'business_home';
import { OrderPage } from 'business_order';
import { BenefitPage } from 'business_benefits';
import { MinePage } from 'business_mine';
import { ControllerModule, ImmersiveMaterialGuard, RouterMap, RouterModule } from 'lib_foundation';
import { TabListItem } from '../types';
import { MainEntryVM } from '../viewmodels/MainEntryVM';
import { WantUtils } from '../utils/WantUtils';
import { WidgetCardVM } from '../viewmodels/WidgetCardVM';

// 悬浮TabBar遮挡补偿：栏高48 + 栏底间距28
const FLOATING_TAB_BAR_CLEARANCE: number = 76;
// 窗口沉浸式已开启时悬浮栏底部的显式间距
const FLOATING_TAB_BAR_BOTTOM_MARGIN: number = 28;


@Builder
export function MainEntryBuilder() {
  MainEntry()
}

@ComponentV2
struct MainEntry {
  vm: MainEntryVM = new MainEntryVM();
  formCardVM: WidgetCardVM = WidgetCardVM.instance;
  @Local opacityList: number[] = [1.0, 0, 0, 0];
  // API 26+ 且设备支持沉浸光感时启用悬浮TabBar分支，低版本与不支持设备保留接入前组件树
  @Local useFloatingTab: boolean = false;
  private controller: TabsController = new TabsController();
  // tab切换动画淡入淡出
  private customContentTransition: (from: number, to: number) => TabContentAnimatedTransition =
    (from: number, to: number) => {
      let tabContentAnimatedTransition = {
        timeout: 1200,
        transition: (proxy: TabContentTransitionProxy) => {
          this.opacityList[from] = 1.0;
          this.opacityList[to] = 0.1;
          this.getUIContext()?.animateTo({
            duration: 200,
            onFinish: () => {
              proxy.finishTransition();
            },
          }, () => {
            this.opacityList[from] = 0.1;
            this.opacityList[to] = 1.0;
          });
        },
      } as TabContentAnimatedTransition;
      return tabContentAnimatedTransition;
    };

  // 桌面快捷方式
  @Monitor('vm.pageRouter.shortcutId')
  shortcutsChange() {
    if (this.vm.pageRouter.shortcutId) {
      WantUtils.jumpToShortcutsPage(this.vm.userInfoModel.isLogin);
    }
  }

  // 服务卡片
  @Monitor('vm.pageRouter.formCardId')
  formCardChange() {
    if (this.vm.pageRouter.formCardId) {
      WantUtils.jumpToFormCardPage();
    }
  }

  @Monitor('vm.userInfoModel.isLogin')
  onLoginChange() {
    this.formCardVM.updateFormCardData(true);
  }

  aboutToAppear() {
    // tabs控制器存起来使用
    ControllerModule.set(this.controller);
    // 启动页已退出、应用启动完成后查询一次沉浸光感能力并复用
    this.useFloatingTab = ImmersiveMaterialGuard.isMaterialSupported();
    this.vm.windowModel.floatingTabBarHeight = this.useFloatingTab ? FLOATING_TAB_BAR_CLEARANCE : 0;
    // 更新服务卡片
    this.formCardVM.updateFormCardData();
    // 开启轮询
    this.formCardVM.startPolling();
    // 服务卡片
    if (this.vm.pageRouter.formCardId) {
      WantUtils.jumpToFormCardPage();
    }
    // 桌面图标
    if (this.vm.pageRouter.shortcutId) {
      WantUtils.jumpToShortcutsPage(this.vm.userInfoModel.isLogin);
    }
  }

  build() {
    NavDestination() {
      Column() {
        if (this.useFloatingTab) {
          Tabs({ barPosition: BarPosition.End, index: this.vm.curIndex, controller: this.controller }) {
            this.tabContents(true)
          }
          .width('100%')
          .height('100%')
          .scrollable(false)
          .vertical(false)
          .barOverlap(true)
          .barHeight(48)
          .barFloatingStyle({
            barBottomMargin: FLOATING_TAB_BAR_BOTTOM_MARGIN,
            maskColor: Color.Transparent,
            adaptToHandedness: true
          })
          .onContentWillChange((currentIndex: number, comingIndex: number) => {
            return this.onContentWillChange(currentIndex, comingIndex);
          })
          .onChange((index: number) => {
            this.vm.curIndex = index;
          })
        } else {
          Tabs({ barPosition: BarPosition.End, index: this.vm.curIndex, controller: this.controller }) {
            this.tabContents(false)
          }
          .width('100%')
          .height('100%')
          .scrollable(false)
          .vertical(this.vm.isTabVertical)
          .barPosition(this.vm.barPosition)
          .barWidth(this.vm.tabWidth)
          .barHeight(this.vm.tabHeight)
          .customContentTransition(this.customContentTransition)
          .onContentWillChange((currentIndex: number, comingIndex: number) => {
            return this.onContentWillChange(currentIndex, comingIndex);
          })
          .onChange((index: number) => {
            this.vm.curIndex = index;
          })
        }
      }
      .width('100%')
      .padding({
        bottom: this.useFloatingTab ? 0 : this.vm.windowModel.windowBottomPadding
      })
      .backgroundColor(Color.White)
    }
    .hideTitleBar(true)
    .hideToolBar(true)
    .onBackPressed(() => {
      return this.vm.onBackPressed();
    })
  }

  private onContentWillChange(currentIndex: number, comingIndex: number): boolean {
    if ((comingIndex === 1 || comingIndex === 2) && !this.vm.userInfoModel.isLogin) {
      RouterModule.push({ url: RouterMap.QUICK_LOGIN_PAGE }, () => {
        this.controller.changeIndex(comingIndex);
      })
      return false;
    }
    return true;
  }

  @Builder
  tabContents(useFloating: boolean) {
    TabContent() {
      HomePage()
    }
    .opacity(useFloating ? 1 : this.opacityList[0])
    .tabBar(this.tabBarBuilder(0, this.vm.tabList[0]))

    TabContent() {
      OrderPage({
        currentTabIndex: this.vm.curIndex
      })
    }
    .opacity(useFloating ? 1 : this.opacityList[1])
    .tabBar(this.tabBarBuilder(1, this.vm.tabList[1]))

    TabContent() {
      BenefitPage()
    }
    .opacity(useFloating ? 1 : this.opacityList[2])
    .tabBar(this.tabBarBuilder(2, this.vm.tabList[2]))

    TabContent() {
      MinePage()
    }
    .opacity(useFloating ? 1 : this.opacityList[3])
    .tabBar(this.tabBarBuilder(3, this.vm.tabList[3]))
  }

  @Builder
  tabBarBuilder(index: number, item: TabListItem) {
    Column() {
      Image(this.vm.curIndex === index ? item.iconChecked : item.icon)
        .width(24)
        .height(24);
      Text(item.label)
        .fontColor(this.vm.curIndex === index ? '#0A59F7' :
          $r('sys.color.icon_secondary'))
        .fontSize(10)
        .margin({ top: 4 });

    }.width('100%');
  }
}