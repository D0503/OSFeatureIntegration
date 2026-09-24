import { CommonTitle, IMMERSIVE_FLOATING_TAB_BAR_HEIGHT, IMMERSIVE_FLOATING_TITLE_HEIGHT } from 'lib_foundation';
import { CommonServiceView } from '../components/CommonServiceView';
import { LoginAvatarCard } from '../components/LoginAvatarCard';
import { MainService } from '../components/MainService';
import { MinePageVM } from '../viewModels/MinePageVM';

@ComponentV2
export struct MinePage {
  vm: MinePageVM = MinePageVM.instance;

  build() {
    Column() {
      if (!this.vm.windowModel.immersiveFloatingTab) {
        CommonTitle({
          title: '我的',
          showBackBtn: false,
          fontSize: 26
        })
      }
      Scroll() {
        Column({ space: 12 }) {
          LoginAvatarCard()
          MainService()
          CommonServiceView()
        }
        .padding({
          left: this.vm.breakPointModel.pagePadding,
          right: this.vm.breakPointModel.pagePadding,
          bottom: this.vm.windowModel.immersiveFloatingTab ? IMMERSIVE_FLOATING_TAB_BAR_HEIGHT : 0,
        })
        .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
          this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: false })
      .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
        this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
    }
    .width('100%')
    .height('100%')
    .padding({
      top: this.vm.windowModel.immersiveFloatingTab ?
        this.vm.windowModel.windowTopPadding + IMMERSIVE_FLOATING_TITLE_HEIGHT : 0
    })
    .backgroundColor($r('sys.color.background_secondary'))
    .expandSafeArea(this.vm.windowModel.immersiveFloatingTab ? [SafeAreaType.SYSTEM] : undefined,
      this.vm.windowModel.immersiveFloatingTab ? [SafeAreaEdge.BOTTOM] : undefined)
  }
}