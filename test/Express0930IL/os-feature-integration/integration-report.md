# 沉浸光感接入汇总报告

工程：D:\HW\OSFeatureIntegration\test\Express0930IL

## 沉浸光感改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| 应用级 MaterialState 开启 | 应用级 / module.json5 | targetSdkVersion 升级至 26.0.0（compatible 保持 20），entry module 配置 ohos.arkui.UIMaterial.state=enable；Toast/Dialog/Sheet/Text 选择菜单等受支持组件获得系统默认材质（未显式配置背景属性，无冲突） | build-profile.json5<br>products/entry/src/main/module.json5 | 未验证 | 未验证 |
| 首页悬浮Tab滚动尾部避让 | 首页 / Scroll | 首页 Scroll 内容 Column 增加 bottom=floatingTabBarHeight(悬浮分支76/否则0) 尾部补偿 | features/business&#95;home/src/main/ets/pages/HomePage.ets | 未验证 | 未验证 |
| 查快递悬浮Tab滚动尾部避让 | 查快递 / WaterFlow | 订单列表 WaterFlow footer 高度 12→12+floatingTabBarHeight，footer 随内容滚动 | features/business&#95;order/src/main/ets/components/OrderListView.ets | 未验证 | 未验证 |
| 福利页悬浮Tab滚动尾部避让 | 福利 / List/Scroll | 普通模式 CouponListSection/TaskListSection 内部 List contentEndOffset 12→12+floatingTabBarHeight；分屏外层滚动模式由外层 Column 条件 padding 补偿 | features/business&#95;benefits/src/main/ets/pages/BenefitPage.ets<br>features/business&#95;benefits/src/main/ets/components/CouponListSection.ets<br>features/business&#95;benefits/src/main/ets/components/TaskListSection.ets | 未验证 | 未验证 |
| 我的页悬浮Tab滚动尾部避让 | 我的 / Scroll | 我的页 Scroll 内容 Column 增加 bottom=floatingTabBarHeight 尾部补偿 | features/business&#95;mine/src/main/ets/pages/MinePage.ets | 未验证 | 未验证 |
| 主页面底部Tabs悬浮栏沉浸光感 | 主页面 / Tabs | 底部 Tabs 增加悬浮分支：barOverlap(true)+vertical(false)+BarPosition.End+barFloatingStyle(barBottomMargin:28、maskColor 透明)；窗口沉浸式已开启故显式28vp；悬浮分支移除外层 barWidth 与页签切换动画；低版本分支完整保留原响应式侧栏组件树 | products/entry/src/main/ets/pages/MainEntry.ets<br>commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets<br>commons/lib&#95;foundation/Index.ets<br>commons/lib&#95;foundation/src/main/ets/model/WindowInfo.ets<br>build-profile.json5<br>products/entry/src/main/module.json5 | 通过 | 未确认 |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 应用级 MaterialState 开启 | ArkUI | 应用级配置 |
| 首页悬浮Tab滚动尾部避让 | ArkUI | 悬浮 Tab 滚动尾部避让 |
| 查快递悬浮Tab滚动尾部避让 | ArkUI | 悬浮 Tab 滚动尾部避让 |
| 福利页悬浮Tab滚动尾部避让 | ArkUI | 悬浮 Tab 滚动尾部避让 |
| 我的页悬浮Tab滚动尾部避让 | ArkUI | 悬浮 Tab 滚动尾部避让 |
| 主页面底部Tabs悬浮栏沉浸光感 | ArkUI | 悬浮 Tab |

## 视觉验证结果

### 应用级 MaterialState 开启

页面 / 组件：应用级 / module.json5。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-10-08T01:52:01.639Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。
### 首页悬浮Tab滚动尾部避让

页面 / 组件：首页 / Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-10-08T01:52:09.436Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。
### 查快递悬浮Tab滚动尾部避让

页面 / 组件：查快递 / WaterFlow。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-10-08T01:52:16.345Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。
### 福利页悬浮Tab滚动尾部避让

页面 / 组件：福利 / List/Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-10-08T01:52:22.549Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。
### 我的页悬浮Tab滚动尾部避让

页面 / 组件：我的 / Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-10-08T01:52:28.604Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。
### 主页面底部Tabs悬浮栏沉浸光感

页面 / 组件：主页面 / Tabs。

视觉结果：**未确认**。截图已采集（主页面首页+底部悬浮TabBar），但本轮判图 AI 不支持图像输入无法实际读取，材质观感（THIN 毛玻璃、深浅色表现）保持未确认；几何布局已由组件树另行判定。请人工查看 evidence 截图或真机确认材质效果

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-10-08T03:35:31.414Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 真机 HUAWEI Mate XT 2（API 26）安装启动并导航至主页面首页成功；组件树证明悬浮分支激活：TabBar bounds &#91;78,2214,1062,2358&#93; 为悬浮胶囊（宽约328vp、左右居中、底距84px=28vp 与显式 barBottomMargin 一致、栏高144px=48vp），透明 BackgroundMask 存在（hitTestBehavior None），页面内容（首页卡片与广告组件延伸至 y=2274）与栏（y 自 2214 起）重叠，barOverlap 生效；四个页签底部横向排列。运行日志无 Error/FATAL/crash，无 Material inactive 越界告警。未覆盖：逐 Tab 滚动末项可达操作、分屏/大断点形态、低版本回退 |

静态复核结论：

- 已复核通过：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/utils/ImmersiveMaterialGuard.ets:18；ImmersiveMaterialGuard.isMaterialSupported() 先经 ARKUI&#95;MIN&#95;API&#95;VERSION=26 常量的 deviceInfo.sdkApiVersion 短路判断再调用 uiMaterial API 26 接口；唯一调用点在 MainEntry aboutToAppear（SplashPage replace 退出启动页之后），保护链完整。
- 已复核通过：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:100、components/aggregated&#95;login/src/main/ets/components/OtherLoginPage.ets:220、components/aggregated&#95;login/src/main/ets/utils/LoginSheetUtils.ets:25；候选页面（AddressListPage/OtherLoginPage/AggregatedLoginPage 等）均为 hideTitleBar(true)+自绘 CommonTitle，不在 NavigationTitleOptions.systemMaterial 生效范围；本次未显式配置系统标题栏材质，走应用级 ENABLE 默认行为，无需 BarStyle.STACK。
- 已复核通过：核对悬浮栏宽度与各断点布局；位置：products/entry/src/main/ets/pages/MainEntry.ets:126、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:98、components/app&#95;setting/src/main/ets/components/CommonConfirmDialog.ets:146；MainEntry 的 .barWidth/.vertical/.barPosition 证据行均位于 else 低版本兼容分支，保留接入前侧栏响应式基线；悬浮分支恒为 vertical(false)+BarPosition.End 且无外层 barWidth；SimpleDialog/CommonConfirmDialog 的 vertical(true) 为对话框内部布局与 Tabs 无关。
- 已复核通过：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:19、commons/lib&#95;foundation/src/main/ets/utils/WindowUtil.ets:132、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:169；EntryAbility.onWindowStageCreate→WindowUtil.setWinConfig→setWindowLayoutFullScreen(true) 调用链已逐行核对，窗口沉浸式已开启；悬浮栏按规则显式 barBottomMargin:28，复用现有窗口沉浸方案未新增 expandSafeArea。
- 已复核通过：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/MainEntry.ets:106、products/entry/src/main/ets/pages/MainEntry.ets:97、commons/lib&#95;foundation/src/main/ets/uicomponent/CommonLoading.ets:21；MainEntry Column 的 bottom padding 按 useFloatingTab 条件分支：悬浮分支为0（栏间距28负责避让），普通分支保留 windowBottomPadding 导航条避让；扫描中其余 bottom padding 均为卡片内容用途，非导航避让。
- 已复核通过：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/lib&#95;foundation/src/main/ets/uicomponent/GridPickerSheet.ets:33、components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:111、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:117；四个一级 Tab 页补偿均落在真实滚动容器且唯一：HomePage/MinePage 为 Scroll 内容 Column 条件 padding，Benefit 普通模式为内部 List contentEndOffset(12+补偿)、分屏模式为外层 Column 条件 padding，OrderPage 为 WaterFlow footer(12+补偿)；二级页面不在主 Tabs 悬浮栏遮挡链内无需补偿；无列表外固定 Blank 兄弟占位。

<img src="evidence/d97ba3b61da4a2e327336289b173c3996753eecec7f9ca8452dc48098145b1d9.png" alt="目标页面截图" width="270" />


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
| 低版本 | 应用级 MaterialState 开启：低版本设备上受支持组件保持接入前普通样式（材质默认行为不生效）<br>首页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>查快递悬浮Tab滚动尾部避让：floatingTabBarHeight=0，footer 保持原 12 间距<br>福利页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，contentEndOffset/padding 恢复原值<br>我的页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>主页面底部Tabs悬浮栏沉浸光感：deviceInfo.sdkApiVersion &#60; 26 时走原 Tabs 组件树（含侧栏响应式、切换动画、windowBottomPadding 避让） | 未验证 | 尚未实际验证 |
| 设备不支持 | 应用级 MaterialState 开启：设备不支持材质时默认材质不生效、不报错，普通样式保留<br>首页悬浮Tab滚动尾部避让：悬浮分支未启用，补偿为0保持接入前滚动范围<br>查快递悬浮Tab滚动尾部避让：floatingTabBarHeight=0，footer 保持原 12 间距<br>福利页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>我的页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>主页面底部Tabs悬浮栏沉浸光感：isImmersiveMaterialSupported()=false 时走原 Tabs 组件树与普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 MaterialState 开启：应用级 DISABLE 时全部材质关闭<br>首页悬浮Tab滚动尾部避让：悬浮分支未启用，补偿为0保持接入前滚动范围<br>查快递悬浮Tab滚动尾部避让：floatingTabBarHeight=0，footer 保持原 12 间距<br>福利页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>我的页悬浮Tab滚动尾部避让：floatingTabBarHeight=0，补偿为0保持接入前滚动范围<br>主页面底部Tabs悬浮栏沉浸光感：MaterialState.DISABLE 时走原 Tabs 组件树与普通样式 | 未验证 | 尚未实际验证 |
