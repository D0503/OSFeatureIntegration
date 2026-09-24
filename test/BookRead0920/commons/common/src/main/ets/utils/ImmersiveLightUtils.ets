import { deviceInfo } from '@kit.BasicServicesKit';

export class ImmersiveLightUtils {
  public static readonly ARKUI_IMMERSIVE_MIN_API_VERSION: number = 26;
  public static readonly FLOATING_TAB_BAR_BOTTOM_MARGIN: number = 0;
  public static readonly FLOATING_TAB_BAR_TAIL_CLEARANCE: number = 68;

  public static isArkuiImmersiveApiAvailable(): boolean {
    return deviceInfo.sdkApiVersion >= ImmersiveLightUtils.ARKUI_IMMERSIVE_MIN_API_VERSION;
  }
}
