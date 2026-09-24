# 沉浸光感接入汇总报告

工程：D:\HW\testproject\osfeaturetest\Express1

## 沉浸光感改造汇总

| 目标 | 页面 / 组件 | 实际改造效果 | 修改文件 |
|---|---|---|---|
| 主页底部Tabs悬浮材质栏+应用级ENABLE全量材质 | 主页 MainEntry（首页/查快递/福利/我的 四Tab） / Tabs | 底部导航接入沉浸光感悬浮材质栏（系统默认THIN），Toast 统一封装注入 THICK 材质，应用级 ENABLE 使 Navigation 标题栏/Menu/Sheet/Select/Toggle/Slider 获得默认材质；四个 Tab 页滚动尾部避让 | build-profile.json5<br>products/entry/src/main/module.json5<br>products/entry/src/main/ets/pages/MainEntry.ets<br>commons/lib&#95;foundation/Index.ets<br>commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets<br>commons/lib&#95;foundation/src/main/ets/utils/ContextUtil.ets<br>commons/lib&#95;foundation/src/main/ets/model/WindowInfo.ets<br>features/business&#95;home/src/main/ets/pages/HomePage.ets<br>features/business&#95;order/src/main/ets/components/OrderListView.ets<br>features/business&#95;benefits/src/main/ets/components/CouponListSection.ets<br>features/business&#95;benefits/src/main/ets/components/TaskListSection.ets<br>features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets<br>features/business&#95;mine/src/main/ets/pages/MinePage.ets |
| 主入口底部悬浮TabBar沉浸光感+标题栏材质+弹窗Toast菜单默认材质 | 主入口（MainEntry 底部 Tabs） / Tabs | 底部导航接入悬浮材质（系统默认 THIN），四个一级 Tab 页滚动末项可完整滚到悬浮栏上方；设置页 NavDestination 标题栏 ULTRA&#95;THIN 材质；Toast/Menu/Dialog/Select 通过应用级 MaterialState=ENABLE 获得默认材质 | build-profile.json5<br>products/entry/src/main/module.json5<br>commons/lib&#95;foundation/Index.ets<br>commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets<br>commons/lib&#95;foundation/src/main/ets/model/WindowInfo.ets<br>products/entry/src/main/ets/pages/MainEntry.ets<br>features/business&#95;home/src/main/ets/pages/HomePage.ets<br>features/business&#95;order/src/main/ets/components/OrderListView.ets<br>features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets<br>features/business&#95;benefits/src/main/ets/components/CouponListSection.ets<br>features/business&#95;benefits/src/main/ets/components/TaskListSection.ets<br>features/business&#95;mine/src/main/ets/pages/MinePage.ets<br>features/business&#95;mine/src/main/ets/pages/SettingPrivacyPage.ets |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 主页底部Tabs悬浮材质栏+应用级ENABLE全量材质 | ArkUI | 悬浮 Tab |
| 主入口底部悬浮TabBar沉浸光感+标题栏材质+弹窗Toast菜单默认材质 | ArkUI | 底部悬浮 TabBar + 原生标题栏 + 弹窗/Toast/菜单 |

## 视觉验证结果

### 主页底部Tabs悬浮材质栏+应用级ENABLE全量材质

视觉结果：**未验证**。未完成目标页视觉验证：SDK 或静态门禁失败，未构建

设备：未指定；系统信息：未采集。

验证时间：2026-09-16T03:44:48.007Z；整体结果：失败。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 失败 | route-eligibility: Route arkui is not available；arkui-navigation-stack: BarStyle.STACK is recommended when the source design allows content to extend behind the title bar；arkui-select-dual-entry: Select button and dropdown menu are independent; verify whether menuSystemMaterial is also required；arkui-material-effect-scope: Static scanning cannot prove the component ancestry; verify navigation-title, bottom-floating-tabbar, or all-page component scope manually；arkui-shadow-conflict: Custom shadow is present; set applyShadow:false when the custom shadow must win；application-level-config: ；scrollable-tab-tail-clearance: A tail-clearance candidate was detected, not verified. Trace each Tab into its actual scrolling child, confirm existing spacing and actual occlusion, and verify the last actionable item can scroll above the bar. Keep the viewport extending behind the bar; page-level bottom padding is not tail-clearance evidence；web-same-layer: API 23 Web same-layer rendering may become transparent; disable material or same-layer rendering |
| SDK | 失败 | 本机 SDK 或工程版本不满足所选路线，需先完成版本门禁 |
| 构建 | 未验证 | SDK 或静态门禁失败，未构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |
| 视觉验证 | 未验证 | 未完成目标页视觉验证：SDK 或静态门禁失败，未构建 |
### 主入口底部悬浮TabBar沉浸光感+标题栏材质+弹窗Toast菜单默认材质

视觉结果：**未确认**。截图 E13 已采集（华为畅享 90 Pro Max，API 26，主入口首页）。组件树 E8 结构化验证悬浮形态全部生效：TabBar bounds &#91;72,2216,1056,2360&#93;（3x 密度）换算为 328vp 居中对称、栏高 48vp、底部悬空 28vp（barBottomMargin），Tabs 内容区延伸至屏幕底部 2444，barOverlap(true) 重叠布局确认。但本轮执行环境不支持读取图片，无法对材质滤镜的视觉观感（毛玻璃/流光/反色）做图像级判定，需人工查看 evidence 截图确认

设备：6UMBB26320007545；系统信息：{<br>  "name": "华为畅享 90 Pro Max",<br>  "serial": "6UMBB26320007545",<br>  "kind": "device",<br>  "deviceType": "phone",<br>  "osVersion": "API 26 (Release)"<br>}。

验证时间：2026-09-17T06:57:58.966Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | version-guard: Static scanning could not confirm API 26 protection. Review constant values, equivalent comparisons, Guard wrappers and their call chains; do not rewrite equivalent source code merely to match a literal pattern. Confirm all API 26 calls, enums and configuration remain protected on lower versions；arkui-navigation-stack: BarStyle.STACK is recommended when the source design allows content to extend behind the title bar；arkui-select-dual-entry: Select button and dropdown menu are independent; verify whether menuSystemMaterial is also required；arkui-material-effect-scope: Static scanning cannot prove the component ancestry; verify navigation-title, bottom-floating-tabbar, or all-page component scope manually；arkui-shadow-conflict: Custom shadow is present; set applyShadow:false when the custom shadow must win；floating-tabs-window-immersion: Confirm the target window's effective setWindowLayoutFullScreen state through initialization, wrappers, parameters, conditions and later disabling calls; source candidates do not prove execution. HDS default barBottomMargin is 0; ArkUI default is 28vp. For integration, explicitly use 28vp when window immersion is enabled; otherwise use 0vp and expandSafeArea SYSTEM/BOTTOM on every first-level Tab page, actual scroll container and all its ancestors. Do not enable global window immersion automatically. Even a detected expansion cannot prove ancestor coverage; verify every page and preserve normal/standalone branches and top avoidance；floating-tabs-bottom-spacing: Floating Tabs and bottom padding were detected with explicit or default bar spacing. Review padding purpose, component ancestry and branch ownership. Keep normal-Tab navigation-bar avoidance padding only in the normal branch; floating content should extend behind the bar. Preserve padding for other layout purposes and scrolling-tail clearance. Static coexistence does not prove a defect and must not trigger automatic margin zeroing or padding removal；scrollable-tab-tail-clearance: A tail-clearance candidate was detected, not verified. Trace each Tab into its actual scrolling child, confirm existing spacing and actual occlusion, and verify the last actionable item can scroll above the bar. Keep the viewport extending behind the bar; page-level bottom padding is not tail-clearance evidence；web-same-layer: API 23 Web same-layer rendering may become transparent; disable material or same-layer rendering |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 未确认 | 已确认：签名构建+安装+启动通过（E4）；导航断言命中，主入口四个 Tab 页签文本（首页/查快递/福利/我的）全部在组件树中出现（E8）；悬浮 TabBar 几何参数（328vp 居中/48vp 高/28vp 底距/barOverlap）经组件树实测验证；运行日志 E10（27KB）无 'Material inactive: out of scope' 告警、无 FATAL/JSAPP 错误——悬浮栏处于合法生效区域。未覆盖：滚动末项可完整滚至悬浮栏上方的交互验证、深浅色切换、系统材质档位（强/均衡/弱）、Toast/Menu 实际弹出的材质观感、设置页标题栏材质（未导航至该页）、低版本回退分支（真机 API 26 无法验证 compatible 20 行为） |
| 视觉验证 | 未确认 | 截图 E13 已采集（华为畅享 90 Pro Max，API 26，主入口首页）。组件树 E8 结构化验证悬浮形态全部生效：TabBar bounds &#91;72,2216,1056,2360&#93;（3x 密度）换算为 328vp 居中对称、栏高 48vp、底部悬空 28vp（barBottomMargin），Tabs 内容区延伸至屏幕底部 2444，barOverlap(true) 重叠布局确认。但本轮执行环境不支持读取图片，无法对材质滤镜的视觉观感（毛玻璃/流光/反色）做图像级判定，需人工查看 evidence 截图确认 |

![目标页面截图](<evidence/d977e139703baad702a6ebf645fa6f52f467e5d9e98ecef3e18e937077db216d.png>)


## 升级与兼容

### 主页底部Tabs悬浮材质栏+应用级ENABLE全量材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | unknown |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | API 26 以下设备保留原 Tabs 布局（vertical/barPosition/barWidth/barHeight）、交互与普通样式；Toast 不注入 systemMaterial | 未验证 | 尚未实际验证 |
| 设备不支持 | 设备不支持沉浸光感时保留原组件状态和普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 DISABLE 或侧边栏断点（LG/XL）时走源程序 Tabs 分支 | 未验证 | 尚未实际验证 |
### 主入口底部悬浮TabBar沉浸光感+标题栏材质+弹窗Toast菜单默认材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | deviceInfo.sdkApiVersion &#60; 26 时 MainEntry 走普通 Tabs 分支（原 vertical/barPosition/barWidth/barHeight 与 windowBottomPadding 避让 padding 完整保留）；floatingTabOcclusion=0 时各页尾部补偿高度为 0，滚动范围与源程序一致；标题栏 titleOptions 为 {} 不含 systemMaterial，不构造材质对象 | 未验证 | 尚未实际验证 |
| 设备不支持 | uiMaterial.isImmersiveMaterialSupported() 为 false 时 materialReady=false 走普通 Tabs 分支，保留原组件树、状态、交互与普通视觉样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | MaterialState.DISABLE 或系统关闭时悬浮布局保留但材质不生效（应用级 DISABLE 时显式材质也不生效）；Toast/Menu/Dialog 恢复系统默认视觉 | 未验证 | 尚未实际验证 |
| vertical-breakpoint | LG/XL 竖向页签断点时 useFloatingTab=false，保留原侧边竖向 Tab 布局（barWidth 96/barHeight 400/barPosition Start）与原避让 padding | 未验证 | 尚未实际验证 |
