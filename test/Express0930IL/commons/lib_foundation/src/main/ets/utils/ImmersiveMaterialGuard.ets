import { deviceInfo } from '@kit.BasicServicesKit';
import { uiMaterial } from '@kit.ArkUI';

/**
 * ImmersiveMaterialGuard —— ArkUI 沉浸式系统材质运行时门禁
 *
 * - uiMaterial 模块 @since 26.0.0；compatibleSdkVersion < 26 时必须先用
 *   deviceInfo.sdkApiVersion >= 26 保护，再调用能力查询；
 * - isImmersiveMaterialSupported() 由设备决定且运行后不变：在应用启动完成、
 *   退出启动加载页后查询一次并复用，不得在模块初始化或启动加载页中调用；
 * - 应用级 MaterialState.DISABLE 时显式 systemMaterial 也不生效；
 * - 不支持的设备上设置材质不报错、无效果，普通样式自动保留。
 */
export class ImmersiveMaterialGuard {
  public static readonly ARKUI_MIN_API_VERSION: number = 26;

  public static isRuntimeApiAvailable(): boolean {
    return deviceInfo.sdkApiVersion >= ImmersiveMaterialGuard.ARKUI_MIN_API_VERSION;
  }

  public static isMaterialSupported(): boolean {
    return ImmersiveMaterialGuard.isRuntimeApiAvailable() &&
      uiMaterial.isImmersiveMaterialSupported() &&
      uiMaterial.getMaterialInfo().state !== uiMaterial.MaterialState.DISABLE;
  }
}
