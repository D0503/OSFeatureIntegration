import { uiMaterial } from '@kit.ArkUI';
import { HomePage } from 'business_home';
import { OrderPage } from 'business_order';
import { BenefitPage } from 'business_benefits';
import { MinePage } from 'business_mine';
import { ControllerModule, IMMERSIVE_FLOATING_TAB_BOTTOM_MARGIN, RouterMap, RouterModule } from 'lib_foundation';
import { TabListItem } from '../types';
import { MainEntryVM } from '../viewmodels/MainEntryVM';
import { WantUtils } from '../utils/WantUtils';
import { WidgetCardVM } from '../viewmodels/WidgetCardVM';


@Builder
export function MainEntryBuilder() {
  MainEntry()
}

@ComponentV2
struct MainEntry {
  vm: MainEntryVM = new MainEntryVM();
  formCardVM: WidgetCardVM = WidgetCardVM.instance;
  @Local opacityList: number[] = [1.0, 0, 0, 0];
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
    if (this.vm.windowModel.immersiveFloatingTab) {
      this.vm.windowModel.immersiveMaterialSupported = uiMaterial.isImmersiveMaterialSupported();
    }
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
        if (this.vm.windowModel.immersiveFloatingTab) {
          Tabs({ barPosition: BarPosition.End, index: this.vm.curIndex, controller: this.controller }) {
            this.homeTab()
            this.orderTab()
            this.benefitTab()
            this.mineTab()
          }
          .width('100%')
          .height('100%')
          .scrollable(false)
          .vertical(false)
          .barHeight(48)
          .barOverlap(true)
          .barFloatingStyle({
            barBottomMargin: IMMERSIVE_FLOATING_TAB_BOTTOM_MARGIN,
            maskColor: Color.Transparent,
            adaptToHandedness: true
          })
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
          .onContentWillChange((currentIndex: number, comingIndex: number) => {
            return this.onTabWillChange(comingIndex);
          })
          .onChange((index: number) => {
            this.vm.curIndex = index;
          })
        } else {
          Tabs({ barPosition: BarPosition.End, index: this.vm.curIndex, controller: this.controller }) {
            this.homeTab()
            this.orderTab()
            this.benefitTab()
            this.mineTab()
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
            return this.onTabWillChange(comingIndex);
          })
          .onChange((index: number) => {
            this.vm.curIndex = index;
          })
        }
      }
      .width('100%')
      .padding({
        bottom: this.vm.windowModel.immersiveFloatingTab ? 0 : this.vm.windowModel.windowBottomPadding
      })
      .backgroundColor(Color.White)
      .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
        this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
    }
    .hideTitleBar(!this.vm.windowModel.immersiveFloatingTab)
    .title(this.vm.tabList[this.vm.curIndex].label, this.vm.windowModel.immersiveFloatingTab ? {
      systemMaterial: this.vm.windowModel.immersiveMaterialSupported ? new uiMaterial.ImmersiveMaterial({
        style: uiMaterial.ImmersiveStyle.ULTRA_THIN,
        colorInvert: true,
        interactive: true,
        lightEffect: {}
      }) : undefined,
      barStyle: BarStyle.STACK
    } : undefined)
    .hideToolBar(true)
    .onBackPressed(() => {
      return this.vm.onBackPressed();
    })
  }

  onTabWillChange(comingIndex: number): boolean {
    if ((comingIndex === 1 || comingIndex === 2) && !this.vm.userInfoModel.isLogin) {
      RouterModule.push({ url: RouterMap.QUICK_LOGIN_PAGE }, () => {
        this.controller.changeIndex(comingIndex);
      })
      return false;
    }
    return true;
  }

  @Builder
  homeTab() {
    TabContent() {
      HomePage()
    }
    .opacity(this.vm.windowModel.immersiveFloatingTab ? 1 : this.opacityList[0])
    .tabBar(this.tabBarBuilder(0, this.vm.tabList[0]))
    .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
      this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
  }

  @Builder
  orderTab() {
    TabContent() {
      OrderPage({
        currentTabIndex: this.vm.curIndex
      })
    }
    .opacity(this.vm.windowModel.immersiveFloatingTab ? 1 : this.opacityList[1])
    .tabBar(this.tabBarBuilder(1, this.vm.tabList[1]))
    .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
      this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
  }

  @Builder
  benefitTab() {
    TabContent() {
      BenefitPage()
    }
    .opacity(this.vm.windowModel.immersiveFloatingTab ? 1 : this.opacityList[2])
    .tabBar(this.tabBarBuilder(2, this.vm.tabList[2]))
    .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
      this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
  }

  @Builder
  mineTab() {
    TabContent() {
      MinePage()
    }
    .opacity(this.vm.windowModel.immersiveFloatingTab ? 1 : this.opacityList[3])
    .tabBar(this.tabBarBuilder(3, this.vm.tabList[3]))
    .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
      this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
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