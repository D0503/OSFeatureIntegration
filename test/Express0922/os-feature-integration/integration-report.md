# 沉浸光感接入汇总报告

工程：D:\HW\testproject\osfeaturetest\Express0922

## 沉浸光感改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| 应用级 MaterialState.enable 与 target 升级 26 | 全局 / module.json5 | entry module.json5 已配置 ohos.arkui.UIMaterial.state=enable；build-profile.json5 targetSdkVersion 已升级为 26.0.0，compatibleSdkVersion 保持 6.0.0(20) | products/entry/src/main/module.json5<br>build-profile.json5 | 未验证 | 未验证 |
| 主入口原生 Tabs 悬浮材质接入 | 主入口 / Tabs | MainEntry 新增沉浸悬浮分支：vertical(false)、BarPosition.End、barOverlap(true)、barFloatingStyle(barBottomMargin=0、maskColor=Transparent、adaptToHandedness)，悬浮分支不含外层 barWidth 与 customContentTransition；外层避让 padding 仅在普通分支保留 | products/entry/src/main/ets/pages/MainEntry.ets<br>commons/lib&#95;foundation/src/main/ets/model/WindowInfo.ets<br>commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets | 未验证 | 未验证 |
| 首页滚动尾部避让 | 首页 / Scroll | 悬浮分支下根 Stack/Scroll/内层 Stack 扩展底部安全区，Scroll 内容末尾增加 48vp 底部 padding（随内容滚动） | features/business&#95;home/src/main/ets/pages/HomePage.ets | 未验证 | 未验证 |
| 查快递页列表滚动尾部避让 | 查快递 / WaterFlow | 悬浮分支下 OrderPage 布局链扩展底部安全区；OrderListView 的 WaterFlow 既有 footer 高度由 12vp 提升为 12+48vp | features/business&#95;order/src/main/ets/pages/OrderPage.ets<br>features/business&#95;order/src/main/ets/components/OrderListView.ets | 未验证 | 未验证 |
| 福利页双窗口模式滚动尾部避让 | 福利 / Scroll/List | 悬浮分支下布局链扩展底部安全区；普通窗口模式由 CouponListSection/TaskListSection 的 List contentEndOffset 12 提升为 12+48vp，分屏模式由外层 Scroll 内容末尾承担 48vp，两层不同时补偿；独立嵌入（VipBenefitPage isTabPage=false）不启用 | features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets<br>features/business&#95;benefits/src/main/ets/components/CouponListSection.ets<br>features/business&#95;benefits/src/main/ets/components/TaskListSection.ets | 未验证 | 未验证 |
| 我的页滚动尾部避让 | 我的 / Scroll | 悬浮分支下根 Column/Scroll/内容 Column 扩展底部安全区，Scroll 内容末尾增加 48vp 底部 padding | features/business&#95;mine/src/main/ets/pages/MinePage.ets | 未验证 | 未验证 |
| 一级页面系统标题栏沉浸光感改造 | 主入口及四个一级页 / NavDestination | 悬浮分支下 MainEntry NavDestination 显示系统标题栏：标题随页签切换，systemMaterial=ULTRA&#95;THIN(colorInvert/interactive/lightEffect)，barStyle=STACK，材质由 isImmersiveMaterialSupported 能力门禁；一级页移除自研 CommonTitle/首页叠加标题层，查快递/福利/我的页补偿顶部占位 windowTopPadding+56vp，首页 banner 延伸到标题栏下方；低版本分支保留 hideTitleBar(true) 与自研标题 | products/entry/src/main/ets/pages/MainEntry.ets<br>commons/lib&#95;foundation/src/main/ets/model/WindowInfo.ets<br>features/business&#95;home/src/main/ets/pages/HomePage.ets<br>features/business&#95;order/src/main/ets/pages/OrderPage.ets<br>features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets<br>features/business&#95;mine/src/main/ets/pages/MinePage.ets | 未验证 | 未验证 |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 应用级 MaterialState.enable 与 target 升级 26 | ArkUI | 应用级开关 |
| 主入口原生 Tabs 悬浮材质接入 | ArkUI | 悬浮 Tab |
| 首页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 查快递页列表滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 福利页双窗口模式滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 我的页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 一级页面系统标题栏沉浸光感改造 | ArkUI | 导航标题栏材质 |

## 视觉验证结果

### 应用级 MaterialState.enable 与 target 升级 26

页面 / 组件：全局 / module.json5。

视觉结果：**未验证**。未完成目标页视觉验证：未请求安装运行

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:20:32.176Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 主入口原生 Tabs 悬浮材质接入

页面 / 组件：主入口 / Tabs。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:35:31.130Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 首页滚动尾部避让

页面 / 组件：首页 / Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:36:02.333Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 查快递页列表滚动尾部避让

页面 / 组件：查快递 / WaterFlow。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:36:06.641Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 福利页双窗口模式滚动尾部避让

页面 / 组件：福利 / Scroll/List。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:36:37.375Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 我的页滚动尾部避让

页面 / 组件：我的 / Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:36:41.780Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；全工程 NavDestination 均 hideTitleBar(true) 并使用自研 CommonTitle，唯一可见系统标题 SettingPrivacyPage(.title('设置')) 由应用级 ENABLE 默认 ULTRA&#95;THIN 覆盖；源设计不要求内容延伸至标题栏，不引入 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:123、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:104；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:99、products/entry/src/main/ets/pages/MainEntry.ets:87、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
### 一级页面系统标题栏沉浸光感改造

页面 / 组件：主入口及四个一级页 / NavDestination。

视觉结果：**未验证**。未完成目标页视觉验证：未请求安装运行

设备：未指定；系统：未采集。

验证时间：2026-09-22T08:54:35.506Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:21；版本门禁使用常量 IMMERSIVE&#95;FLOATING&#95;TAB&#95;MIN&#95;API=26（WindowUtil.ets:21，deviceInfo.sdkApiVersion，API 8 起可用）；ImmersiveMaterial/ImmersiveStyle 构造与 barFloatingStyle 仅在 immersiveFloatingTab=true 的组件树分支内执行，低版本不触碰 API 26 符号。
- 已复核通过：分别核对 Select 按钮与下拉菜单材质入口；位置：features/business&#95;order/src/main/ets/components/StateBar.ets:53、products/entry/src/main/ets/pages/MainEntry.ets:148；StateBar.ets:53 的 Select 未显式设置材质，应用级 ENABLE 下按钮与下拉菜单按系统默认 ULTRA&#95;THIN+THICK 生效，无需分别配置。
- 已复核通过：核对反色所用颜色资源；位置：products/entry/src/main/ets/pages/MainEntry.ets:150、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonNoticeBar.ets:19、features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets:292；colorInvert 仅作用于 NavDestination 系统标题栏子树（系统标题文字与返回键使用系统资源，支持反色）；扫描命中的硬编码颜色均在业务组件内，不在标题栏材质区域内。
- 已复核通过：核对自定义阴影与材质阴影是否冲突；位置：components/address&#95;management/src/main/ets/components/SpeechRecordDialog.ets:153；SpeechRecordDialog.ets:153 的自定义阴影所在弹窗未设置材质，不存在材质阴影覆盖冲突。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:127、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry.ets 低版本分支保留 .vertical(isTabVertical)/.barWidth/.barPosition；悬浮分支固定 vertical(false)+BarPosition.End 且无外层 barWidth；其余 vertical(true) 命中均为弹窗内 List 等非主 Tabs。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:134、components/module&#95;auth/src/main/ets/views/RealNameAuthView.ets:185、products/entry/src/main/ets/pages/MainEntry.ets:108；WindowUtil.setWindowScreen 无调用方，窗口未开启沉浸式；悬浮分支 barBottomMargin=0 且一级 Tab 页到真实滚动容器全链配置 expandSafeArea(&#91;SYSTEM&#93;,&#91;BOTTOM&#93;)，未自动开启全局沉浸式。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:103、products/entry/src/main/ets/pages/MainEntry.ets:91、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry 外层 Column 底部导航条避让 padding 以 immersiveFloatingTab 为条件仅保留在普通分支；悬浮分支由栏底部间距负责。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；各页补偿均落在真实滚动容器既有尾部配置（首页/我的页 Scroll 内容末尾 padding、查快递 WaterFlow footer 12→60vp、福利页普通模式 List contentEndOffset 与分屏模式外层 Scroll 分离），无列表外固定占位与重复补偿。
- 已复核通过：核对 Web 同层渲染的透明异常风险；位置：components/aggregated&#95;login/src/main/ets/views/ProtocolWebView.ets:1、components/aggregated&#95;login/src/main/ets/views/ProtocolWebView.ets:21、components/aggregated&#95;login/src/main/ets/views/ProtocolWebView.ets:128；Web 同层透明限制针对 API 23 及以前的 HDS 路线场景；本工程为 ArkUI 路线且 ProtocolWebView/SettingH5 等 Web 页未设置材质，不涉及。

## 升级与兼容

SDK 版本与回退行为按整个工程记录一份；保留行为覆盖所有改造项。

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 应用级 MaterialState.enable 与 target 升级 26：API 26 以下设备忽略该 metadata，组件保持接入前默认样式<br>主入口原生 Tabs 悬浮材质接入：sdkApiVersion&#60;26 走原响应式 Tabs 分支（侧栏/底部、barWidth/barHeight、淡入淡出动画、底部避让 padding 全部保留）<br>首页滚动尾部避让：低版本分支不扩展安全区、不增加尾部 padding，保持接入前滚动范围<br>查快递页列表滚动尾部避让：低版本分支保持原 footer 12vp 与原布局链<br>福利页双窗口模式滚动尾部避让：低版本分支保持原 contentEndOffset 与原滚动范围<br>我的页滚动尾部避让：低版本分支不扩展安全区、不增加尾部 padding<br>一级页面系统标题栏沉浸光感改造：sdkApiVersion&#60;26 保持 hideTitleBar(true) 与各自研标题（CommonTitle/首页滚动渐显标题），布局与交互不变 | 未验证 | 尚未实际验证 |
| 设备不支持 | 应用级 MaterialState.enable 与 target 升级 26：设备不支持材质时系统不生效，保留原普通样式<br>主入口原生 Tabs 悬浮材质接入：API26 但不支持材质的设备保持底部悬浮布局与尾部避让，仅材质不生效<br>首页滚动尾部避让：保持底部悬浮布局与尾部避让<br>查快递页列表滚动尾部避让：保持底部悬浮布局与尾部避让<br>福利页双窗口模式滚动尾部避让：保持底部悬浮布局与尾部避让<br>我的页滚动尾部避让：保持底部悬浮布局与尾部避让<br>一级页面系统标题栏沉浸光感改造：设备不支持材质时保留系统标题栏与 STACK 布局，标题栏呈普通样式，显式材质不设置 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 MaterialState.enable 与 target 升级 26：系统或应用关闭材质时恢复组件默认行为<br>主入口原生 Tabs 悬浮材质接入：材质关闭时保持底部悬浮布局与普通样式<br>首页滚动尾部避让：保持底部悬浮布局与尾部避让<br>查快递页列表滚动尾部避让：保持底部悬浮布局与尾部避让<br>福利页双窗口模式滚动尾部避让：保持底部悬浮布局与尾部避让<br>我的页滚动尾部避让：保持底部悬浮布局与尾部避让<br>一级页面系统标题栏沉浸光感改造：应用级 DISABLE 或系统关闭时材质不生效，保留标题栏布局与普通样式 | 未验证 | 尚未实际验证 |
