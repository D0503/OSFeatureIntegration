export const IMMERSIVE_FLOATING_TAB_MIN_API: number = 26;
export const IMMERSIVE_FLOATING_TAB_BAR_HEIGHT: number = 48;
export const IMMERSIVE_FLOATING_TAB_BOTTOM_MARGIN: number = 0;
export const IMMERSIVE_FLOATING_TITLE_HEIGHT: number = 56;

/**
 * 窗口持久化
 */
@ObservedV2
export class WindowInfo {
  @Trace windowTopPadding: number = 40;
  @Trace windowBottomPadding: number = 28;
  @Trace windowWidth: number = 0; // 单位px
  @Trace windowHeight: number = 0; // 单位px
  @Trace immersiveFloatingTab: boolean = false;
  @Trace immersiveMaterialSupported: boolean = false;
}