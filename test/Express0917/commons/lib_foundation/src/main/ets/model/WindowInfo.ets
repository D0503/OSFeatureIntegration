/**
 * 窗口持久化
 */
@ObservedV2
export class WindowInfo {
  @Trace windowTopPadding: number = 40;
  @Trace windowBottomPadding: number = 28;
  @Trace windowWidth: number = 0; // 单位px
  @Trace windowHeight: number = 0; // 单位px
  // 沉浸光感悬浮 TabBar 对滚动内容的遮挡补偿（barHeight + barBottomMargin）；非悬浮态为 0
  @Trace floatingTabOcclusion: number = 0;
}