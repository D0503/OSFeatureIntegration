/**
 * 窗口持久化
 */
@ObservedV2
export class WindowInfo {
  @Trace windowTopPadding: number = 40;
  @Trace windowBottomPadding: number = 28;
  @Trace windowWidth: number = 0; // 单位px
  @Trace windowHeight: number = 0; // 单位px
  // 沉浸光感悬浮TabBar遮挡补偿高度，0表示非悬浮分支，滚动容器按此值增加尾部避让
  @Trace floatingTabBarHeight: number = 0;
}