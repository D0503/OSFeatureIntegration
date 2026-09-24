import { deviceInfo } from '@kit.BasicServicesKit';
import { uiMaterial } from '@kit.ArkUI';

/**
 * ImmersiveMaterialGuard.ets —— ArkUI 沉浸式系统材质（沉浸光感）运行时门禁与场景材质工厂
 *
 * 来源：官方《开启沉浸光感》《组件适配沉浸光感》与 @ohos.arkui.uiMaterial API 参考。
 *
 * 关键版本与能力事实：
 * - uiMaterial 模块、ImmersiveMaterial、isImmersiveMaterialSupported：@since 26.0.0，Stage 模型。
 * - targetSdkVersion 与 compileSdkVersion 必须达到 26；compatibleSdkVersion 保持 20，
 *   低版本设备使用低版本即可用的 deviceInfo.sdkApiVersion（@since 8）做最外层保护，
 *   不使用 API 26 才存在的 deviceInfo.apiAvailable。
 * - isImmersiveMaterialSupported() 由设备决定、应用运行后不会改变：只允许在应用启动完成、
 *   退出启动加载页后的业务页面流程中调用（页面 build/aboutToAppear），查询一次并缓存复用；
 *   不得在模块顶层、静态或成员字段初始化、启动加载页中调用。
 * - 不支持沉浸式材质的设备上设置 ImmersiveMaterial 不报错、无效果，普通样式自动保留。
 * - 应用级 MaterialState.DISABLE 时，显式 systemMaterial 也不生效。
 */
export class ImmersiveMaterialGuard {
  /** ArkUI 沉浸光感路线（uiMaterial/systemMaterial）的最低 API */
  private static readonly ARKUI_MIN_API_VERSION: number = 26;

  /** 悬浮 TabBar 栏底部间距：窗口已开启沉浸式（setWindowLayoutFullScreen(true)）时显式 28vp */
  public static readonly FLOATING_TAB_BAR_BOTTOM_MARGIN: number = 28;

  /** 悬浮 TabBar 滚动尾部避让：默认栏高 56vp + 栏底部间距 28vp */
  public static readonly FLOATING_TAB_TAIL_CLEARANCE: number = 84;

  /** 设备能力缓存：undefined 表示尚未查询（启动未就绪时不查询、不缓存默认值） */
  private static materialSupported: boolean | undefined = undefined;

  /** 当前运行设备是否达到 ArkUI 沉浸光感接口版本（低版本设备可安全调用） */
  public static isRuntimeApiAvailable(): boolean {
    return deviceInfo.sdkApiVersion >= ImmersiveMaterialGuard.ARKUI_MIN_API_VERSION;
  }

  /**
   * 当前设备是否可用 ArkUI 沉浸式系统材质。
   * 版本（sdkApiVersion）与设备能力（isImmersiveMaterialSupported）双重判断；
   * 仅在应用启动完成、业务页面就绪后调用，查询一次并复用结果。
   */
  public static isMaterialSupported(): boolean {
    if (!ImmersiveMaterialGuard.isRuntimeApiAvailable()) {
      return false;
    }
    if (ImmersiveMaterialGuard.materialSupported === undefined) {
      ImmersiveMaterialGuard.materialSupported = uiMaterial.isImmersiveMaterialSupported();
    }
    return ImmersiveMaterialGuard.materialSupported;
  }

  /**
   * 首页底部悬浮 TabBar 布局是否启用。
   * 仅由运行版本决定（布局分支门禁）：API 26+ 全断点使用底部横向悬浮 Tab；
   * 设备不支持材质或系统关闭材质时悬浮布局保持，仅材质回退为普通样式。
   */
  public static isFloatingTabBarEnabled(): boolean {
    return ImmersiveMaterialGuard.isRuntimeApiAvailable();
  }

  /**
   * Navigation/NavDestination 标题栏材质。
   * 版本与设备能力均满足时返回 ULTRA_THIN 材质（含自动反色、按压交互与触摸流光）；
   * 否则返回 undefined，标题栏保持接入前普通样式。
   */
  public static navigationTitleMaterial(): uiMaterial.ImmersiveMaterial | undefined {
    if (!ImmersiveMaterialGuard.isMaterialSupported()) {
      return undefined;
    }
    return new uiMaterial.ImmersiveMaterial({
      style: uiMaterial.ImmersiveStyle.ULTRA_THIN,
      colorInvert: true,
      interactive: true,
      lightEffect: {}
    });
  }
}
