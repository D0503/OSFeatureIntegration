# 沉浸光感接入汇总报告

工程：D:\HW\testproject\osfeaturetest\HouseholdService0918

## 沉浸光感改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| 首页底部悬浮TabBar：API26+分支悬浮样式与系统默认THIN材质、三页签切换与首页滚动尾部避让 | 首页主框架 Main / Tabs | API 26+ 分支已配置 vertical(false)+BarPosition.End+barOverlap(true)+barFloatingStyle(barBottomMargin=28vp, adaptToHandedness)，悬浮生效后系统默认 THIN 材质；外层导航条避让 padding 在悬浮分支归零；视觉与滚动效果待验证 | products/entry/src/main/ets/pages/Main.ets<br>commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets | 未验证 | 未验证 |
| 应用级 MaterialState=enable 与 targetSdkVersion 26 升级配置 | 应用级配置 / module.json5 metadata | entry module.json5 已配置 ohos.arkui.UIMaterial.state=enable；targetSdkVersion 已升级为 26.0.0，compile 26（本机 SDK 默认），compatibleSdkVersion 保持 6.0.0(20) | build-profile.json5<br>products/entry/src/main/module.json5 | 未验证 | 未验证 |
| 首页Tab：标题栏材质与列表尾部避让 | 首页 Tab HomePage / NavDestination 标题栏 + 服务列表 List | 标题栏已接入 systemMaterial(ULTRA&#95;THIN/colorInvert/interactive/lightEffect，门禁不满足时 undefined)；服务列表 List 已添加 contentEndOffset(84vp) 尾部补偿；NavDestination 底部 padding 悬浮分支归零 | features/business&#95;home/src/main/ets/pages/HomePage.ets | 未验证 | 未验证 |
| 全部服务Tab：标题栏材质与双侧列表尾部避让 | 全部服务 Tab AllCategory / NavDestination 标题栏 + CategoryList 双侧 List | 标题栏已接入 systemMaterial；CategoryList 新增 tailClearance 参数并对左侧分类 List 与右侧商品 List 设置 contentEndOffset(84vp)；NavDestination 底部 padding 悬浮分支归零 | products/entry/src/main/ets/components/AllCategory.ets<br>components/category&#95;list/src/main/ets/components/CategoryList.ets | 未验证 | 未验证 |
| 我的Tab：滚动内容尾部避让 | 我的 Tab Mine / Scroll 内容尾部 | Scroll 内容末尾 padding 悬浮分支设为 84vp 尾部补偿；外层 Stack 底部 padding 悬浮分支归零；低版本分支保留原断点 padding | features/business&#95;mine/src/main/ets/pages/Mine.ets | 未验证 | 未验证 |
| 立即预约页标题栏材质 | 立即预约 OrderPage / NavDestination 标题栏 | 标题栏已接入 systemMaterial；材质生效时移除标题栏不透明 backgroundColor 以免遮挡，不支持时保留原背景色 | features/business&#95;home/src/main/ets/pages/OrderPage.ets | 未验证 | 未验证 |
| 城市选择页标题栏材质 | 城市选择 CitySelectPage / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;home/src/main/ets/pages/CitySelectPage.ets | 未验证 | 未验证 |
| 官网页标题栏材质 | 官网 OfficialWeb / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;mine/src/main/ets/pages/OfficialWeb.ets | 未验证 | 未验证 |
| 我的订单页标题栏材质 | 我的订单 MyOrderList / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;mine/src/main/ets/pages/MyOrderList.ets | 未验证 | 未验证 |
| 订单详情页标题栏材质 | 订单详情 MyOrderDetail / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;mine/src/main/ets/pages/MyOrderDetail.ets | 未验证 | 未验证 |
| 编辑资料页标题栏材质 | 编辑资料 EditPersonal / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;mine/src/main/ets/pages/EditPersonal.ets | 未验证 | 未验证 |
| 公共服务页标题栏材质 | 公共服务 CommonService / NavDestination 标题栏 | 标题栏已接入 systemMaterial（门禁不满足时 undefined） | features/business&#95;mine/src/main/ets/pages/CommonService.ets | 未验证 | 未验证 |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 首页底部悬浮TabBar：API26+分支悬浮样式与系统默认THIN材质、三页签切换与首页滚动尾部避让 | ArkUI | 悬浮 Tab |
| 应用级 MaterialState=enable 与 targetSdkVersion 26 升级配置 | ArkUI | 应用级开关 |
| 首页Tab：标题栏材质与列表尾部避让 | ArkUI | 标题栏材质 + 滚动尾部避让 |
| 全部服务Tab：标题栏材质与双侧列表尾部避让 | ArkUI | 标题栏材质 + 滚动尾部避让 |
| 我的Tab：滚动内容尾部避让 | ArkUI | 滚动尾部避让 |
| 立即预约页标题栏材质 | ArkUI | 标题栏材质 |
| 城市选择页标题栏材质 | ArkUI | 标题栏材质 |
| 官网页标题栏材质 | ArkUI | 标题栏材质 |
| 我的订单页标题栏材质 | ArkUI | 标题栏材质 |
| 订单详情页标题栏材质 | ArkUI | 标题栏材质 |
| 编辑资料页标题栏材质 | ArkUI | 标题栏材质 |
| 公共服务页标题栏材质 | ArkUI | 标题栏材质 |

## 视觉验证结果

### 首页底部悬浮TabBar：API26+分支悬浮样式与系统默认THIN材质、三页签切换与首页滚动尾部避让

页面 / 组件：首页主框架 Main / Tabs。

视觉结果：**未验证**。未完成目标页视觉验证：构建失败：hvigor build；e signingConfigs in D:\HW\testproject\osfeaturetest\HouseholdService0918\build-profile.json5.&#91;39m<br>&#62; hvigor &#91;33mWARN: 2026/09/18 15:45:25.131 - Ohos BundleTool &#91;Warning&#93;: ModuleJsonUtil::parsePackInfoExtensionAbility error: summary.modules.extensionAbilities is null.<br>2026/09/18 15:45:25.132 - Ohos BundleTool &#91;Warning&#93;: ModuleJsonUtil::parsePackInfoExtensionAbility error: summary.modules.extensionAbilities is null.<br>&#91;39m<br>&#62; hvigor &#91;91mERROR: Failed ::PackageApp... &#91;39m<br>&#62; hvigor &#91;91mERROR: Tools execution failed.<br>2026/09/18 15:45:25.911 - Ohos BundleTool &#91;Error&#93;: 10016016 Check file size failed.<br>Error Message: Module business&#95;home's size is 2149.42KB, which is overlarge than 2048KB.<br><br>&#42; Try the following: <br> &#62; Please check and reduced related module size.<br><br>2026/09/18 15:45:25.911 - Ohos BundleTool &#91;Error&#93;: 10012024 Check atomicService size failed.<br>Error Message: The size of a single module, or the size of a module plus its dependencies, exceeds the maximum.<br><br>&#42; Try the following: <br> &#62; Please check the related size check error message and reduce related module size.<br><br>2026/09/18 15:45:25.911 - Ohos BundleTool &#91;Error&#93;: 10012001 Execute compress process failed.<br>Error Message: Compress process failed.<br><br>&#42; Try the following: <br> &#62; Please check the first error message for more details and modify accordingly.<br><br>2026/09/18 15:45:25.912 - Ohos BundleTool &#91;Error&#93;: 10010001 Execute packing tool failed.<br>Error Message: Compress failed.<br><br>&#42; Try the following: <br> &#62; Please check the first error message for more details and modify accordingly.<br>	 Detail: Please check the message from tools.<br><br>&#91;31m&#42; Try:<br>&#62; Run with --stacktrace option to get the stack trace.<br>&#62; Run with --debug option to get more log output.<br>&#91;39m<br>&#62; hvigor &#91;91mERROR: BUILD FAILED in 35 s 420 ms &#91;39m<br>

设备：7TZ0126602000513；系统：未采集。

验证时间：2026-09-18T07:44:41.061Z；整体结果：失败。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 失败 | 构建失败，停止于HAP 打包；未继续安装，修复后需重验 |
| 安装启动 | 未验证 | 本轮构建未通过，未安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 应用级 MaterialState=enable 与 targetSdkVersion 26 升级配置

页面 / 组件：应用级配置 / module.json5 metadata。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:24.818Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 首页Tab：标题栏材质与列表尾部避让

页面 / 组件：首页 Tab HomePage / NavDestination 标题栏 + 服务列表 List。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:27.508Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 全部服务Tab：标题栏材质与双侧列表尾部避让

页面 / 组件：全部服务 Tab AllCategory / NavDestination 标题栏 + CategoryList 双侧 List。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:29.947Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 我的Tab：滚动内容尾部避让

页面 / 组件：我的 Tab Mine / Scroll 内容尾部。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:32.442Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 立即预约页标题栏材质

页面 / 组件：立即预约 OrderPage / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:34.875Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 城市选择页标题栏材质

页面 / 组件：城市选择 CitySelectPage / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:37.205Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 官网页标题栏材质

页面 / 组件：官网 OfficialWeb / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:39.530Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 我的订单页标题栏材质

页面 / 组件：我的订单 MyOrderList / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:42.042Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 订单详情页标题栏材质

页面 / 组件：订单详情 MyOrderDetail / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:44.490Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 编辑资料页标题栏材质

页面 / 组件：编辑资料 EditPersonal / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:46.997Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。
### 公共服务页标题栏材质

页面 / 组件：公共服务 CommonService / NavDestination 标题栏。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T07:48:49.449Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/lib&#95;foundation/src/main/ets/common/ImmersiveMaterialGuard.ets:35。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/address&#95;management/src/main/ets/pages/AddressListPage.ets:53、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:24、components/collect&#95;personal&#95;info/src/main/ets/components/EnterPhoneNumber.ets:99。
- 待核对：核对悬浮栏宽度与各断点布局；位置：features/business&#95;mine/src/main/ets/pages/MyOrderList.ets:69、products/entry/src/main/ets/pages/Main.ets:228、components/address&#95;management/src/main/ets/utils/SimpleDialog.ets:96。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/lib&#95;foundation/src/main/ets/common/WindowUtils.ets:21、components/module&#95;time&#95;select/src/main/ets/components/TimeSelect.ets:122、features/business&#95;home/src/main/ets/pages/GoodDetail.ets:435。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：products/entry/src/main/ets/pages/Main.ets:213、products/entry/src/main/ets/pages/Main.ets:205、components/address&#95;management/src/main/ets/components/FormInputItem.ets:46。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：components/address&#95;management/src/main/ets/pages/AddressFormSheetPage.ets:96、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:70、components/address&#95;management/src/main/ets/pages/AddressListPage.ets:139。

## 升级与兼容

### 首页底部悬浮TabBar：API26+分支悬浮样式与系统默认THIN材质、三页签切换与首页滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原响应式侧边(LG/XL)/底部 Tabs、barWidth/barHeight/divider、控制器与点击事件、底部避让 padding | 未验证 | 尚未实际验证 |
| 设备不支持 | 保持底部悬浮布局，材质回退普通样式，尾部避让仍生效 | 未验证 | 尚未实际验证 |
| 材质关闭 | 保持底部悬浮布局，系统禁止材质，保留普通样式 | 未验证 | 尚未实际验证 |
### 应用级 MaterialState=enable 与 targetSdkVersion 26 升级配置

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 低版本设备不读取该 metadata，行为与接入前一致 | 未验证 | 尚未实际验证 |
| 设备不支持 | 设备不支持材质时设置不生效，保留普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 用户侧关闭时系统统一禁止材质，保留普通样式 | 未验证 | 尚未实际验证 |
### 首页Tab：标题栏材质与列表尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 标题栏与列表保持接入前样式，contentEndOffset 为 0、底部 padding 保留原断点逻辑 | 未验证 | 尚未实际验证 |
| 设备不支持 | 标题栏 undefined 恢复默认行为，悬浮栏普通样式下尾部避让仍生效 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式与交互 | 未验证 | 尚未实际验证 |
### 全部服务Tab：标题栏材质与双侧列表尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | tailClearance 传 0，标题栏与列表保持接入前样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 标题栏恢复默认行为，尾部避让仍生效 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式与交互 | 未验证 | 尚未实际验证 |
### 我的Tab：滚动内容尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留接入前 padding 与滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 悬浮栏普通样式下尾部避让仍生效 | 未验证 | 尚未实际验证 |
| 材质关闭 | 保留普通样式与交互 | 未验证 | 尚未实际验证 |
### 立即预约页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原标题栏背景色与普通样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原标题栏背景色与普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 城市选择页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 官网页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 我的订单页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 订单详情页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 编辑资料页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
### 公共服务页标题栏材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保留原普通标题栏样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质被禁止，保留普通样式 | 未验证 | 尚未实际验证 |
