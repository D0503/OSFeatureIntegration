# 沉浸光感接入汇总报告

工程：D:\HW\testproject\osfeaturetest\BookRead0920

## 沉浸光感改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| 应用级开启沉浸光感并升级 targetSdkVersion 至 26 | 应用级配置 / module metadata | targetSdkVersion 已升级为 26.0.0（compatibleSdkVersion 保持 6.0.0(20)），entry module 已配置 ohos.arkui.UIMaterial.state=enable | build-profile.json5<br>entry/src/main/module.json5 | 通过 | 通过 |
| 首页原生 Tabs 悬浮材质接入 | 首页主框架 / Tabs | API 26 分支已配置 barPosition End + vertical(false) + barOverlap(true) + barFloatingStyle(barBottomMargin=0, adaptToHandedness)，移除外层 barWidth 与 bottom padding，系统默认 THIN 材质；低版本分支保留原侧边/底部响应式布局、barWidth 与 padding | entry/src/main/ets/pages/BookHomePage.ets<br>entry/src/main/ets/pages/Index.ets<br>commons/common/src/main/ets/utils/ImmersiveLightUtils.ets | 通过 | 通过 |
| 书架页滚动尾部避让 | 书架页 / Scroll | 宫格/列表两种模式的内容末尾 padding 已增加悬浮栏遮挡补偿，根 Stack、内容 Column 与真实滚动 Scroll 已按悬浮分支配置 expandSafeArea SYSTEM/BOTTOM | feature/book&#95;shelf/src/main/ets/views/BookShelfPage.ets | 通过 | 未确认 |
| 书城页列表滚动尾部避让 | 书城页 / List | 主 List 已按悬浮分支添加 contentEndOffset 尾部补偿，根 Stack、内容 Column 与 List 已配置 expandSafeArea SYSTEM/BOTTOM | feature/book&#95;home/src/main/ets/views/BookListPage.ets | 通过 | 通过 |
| 分类页双列表滚动尾部避让 | 分类页 / List | 左侧分类 List 与右侧书籍 List 均已按悬浮分支添加 contentEndOffset 尾部补偿，页面根 Column 至两个 List 的完整父链已配置 expandSafeArea SYSTEM/BOTTOM | feature/book&#95;sort/src/main/ets/pages/BookSortPage.ets | 通过 | 通过 |
| 我的页滚动尾部避让 | 我的页 / Scroll | 真实滚动 Scroll 的内容 Column 末尾已按悬浮分支添加尾部补偿，根 Stack、内容 Column 与 Scroll 已配置 expandSafeArea SYSTEM/BOTTOM | feature/book&#95;person/src/main/ets/views/PersonPage.ets | 通过 | 通过 |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 应用级开启沉浸光感并升级 targetSdkVersion 至 26 | ArkUI | 应用级开启 |
| 首页原生 Tabs 悬浮材质接入 | ArkUI | 悬浮 Tab |
| 书架页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 书城页列表滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 分类页双列表滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 我的页滚动尾部避让 | ArkUI | 滚动尾部避让 |

## 视觉验证结果

### 应用级开启沉浸光感并升级 targetSdkVersion 至 26

页面 / 组件：应用级配置 / module metadata。

视觉结果：**通过**。真机（Mate XT 2，API 26 Release）启动后进入书架首页，底部呈现胶囊形悬浮 Tab 栏，应用级 enable 与 target 26 配置生效；未覆盖深浅色与系统材质档位切换

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T02:34:55.347Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 应用安装启动成功并导航至书架页，运行日志中无应用侧材质相关错误（仅系统 accessibility/AOD 噪声）；低版本与不支持设备回退路径未覆盖 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/7dce3377fe15f8f74f9d70b0617d87e1c67bc3cb73eba845b0e06416733567d0.png>)

### 首页原生 Tabs 悬浮材质接入

页面 / 组件：首页主框架 / Tabs。

视觉结果：**通过**。底部原生 Tabs 呈现胶囊形悬浮栏：左右留白、圆角背板、位于手势条上方且页签图标文字完整；页面为纯色背景，THIN 材质的透光差异不明显，滚动场景下的材质观感在各 Tab 页滚动项中继续验证；未覆盖横竖屏/分屏/自由窗口形态

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T02:37:17.436Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 应用安装启动成功，悬浮布局分支在 API 26 真机生效且页签可点击切换；运行日志无应用侧异常；低版本分支回退未覆盖 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/9ace72b77d1704946c3a354e3fea5cae3bca5816c2d71e2508ed50d11b5681d2.png>)

### 书架页滚动尾部避让

页面 / 组件：书架页 / Scroll。

视觉结果：**未确认**。书架为空（仅一张逛逛书城卡片），内容不足一屏，两次上滑均未产生滚动，尾部避让与末项滚出悬浮栏无法在本数据状态下验证；页面布局与悬浮栏位置正常，末项卡片本就完整位于悬浮栏上方

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T02:38:56.974Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 应用启动并停留在书架页，执行上滑交互无异常日志；滚动行为因无足够内容未触发 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/75cb13260f80c38ee648ad869c3d156f444805991e672c56e3355a32cbea76e2.png>)

### 书城页列表滚动尾部避让

页面 / 组件：书城页 / List。

视觉结果：**通过**。书城页连续上滑至列表末尾：滚动过程中卡片内容正常经过悬浮栏下方且栏背板呈材质透光效果；末尾换一批按钮与猜你喜欢书卡完整滚出悬浮栏遮挡，无固定底部空带，contentEndOffset 尾部补偿生效

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T02:55:52.335Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 书城页切换与连续滚动无异常日志，末项处于可点击区域；低版本回退路径未覆盖 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/b9b4c5fae81cdf6d355778ac4b858816fea4d31d43f7b1fb46ced0c394dde39f.png>)

### 分类页双列表滚动尾部避让

页面 / 组件：分类页 / List。

视觉结果：**通过**。分类页连续上滑后：右侧书籍列表滚至衍生分组末尾，最后可操作标签求生完整位于悬浮栏上方；左侧分类列表末项衍生同步联动且完整可见；双列表 contentEndOffset 尾部补偿生效，无固定底部空带

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T03:00:33.570Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 分类页切换与滚动联动（onScrollIndex 同步左侧选中态）无异常日志；低版本回退路径未覆盖 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/a979fd48c115b69bc1dc5890d0f7b2a496aa0e836805604a37a5fc14bce22ab7.png>)

### 我的页滚动尾部避让

页面 / 组件：我的页 / Scroll。

视觉结果：**通过**。我的页连续上滑至内容末尾：最后可操作项问题与反馈完整滚出悬浮栏遮挡并保留操作间隔，内容延伸布局正常，Scroll 内容末尾补偿生效，无固定底部空带

设备：HUAWEI Mate XT 2 &#124; ULTIMATE DESIGN；系统：API 26 (Release)。

验证时间：2026-09-20T03:05:27.171Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 通过 | 我的页切换与滚动无异常日志，末项处于可点击区域；低版本回退路径未覆盖 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：commons/common/src/main/ets/utils/ImmersiveLightUtils.ets:9。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:98、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:122、entry/src/main/ets/pages/BookHomePage.ets:121、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41、components/customer&#95;service&#95;chat/src/main/ets/components/ChatInput.ets:196。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:98、entry/src/main/ets/pages/BookHomePage.ets:82、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/c05c18df8ada596e71fffdee2d8a07bd7690f0e3128d60fb52aff029111e88e1.png>)


## 升级与兼容

### 应用级开启沉浸光感并升级 targetSdkVersion 至 26

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | API 26 以下设备不执行悬浮布局分支，保留接入前组件树与普通样式 | 未验证 | 尚未实际验证 |
| 设备不支持 | 设备不支持材质时系统自动回退普通样式，不覆盖通用属性 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 DISABLE 时显式材质也不生效，保留普通样式 | 未验证 | 尚未实际验证 |
### 首页原生 Tabs 悬浮材质接入

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留接入前 Tabs 响应式布局、栏宽、底部 padding 与交互 | 未验证 | 尚未实际验证 |
| 设备不支持 | 保持底部悬浮布局，仅材质回退为普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 保持底部悬浮布局与普通样式 | 未验证 | 尚未实际验证 |
### 书架页滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 保留原 15vp 尾部 padding 与滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
| 材质关闭 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
### 书城页列表滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | contentEndOffset 为 0，保留原滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
| 材质关闭 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
### 分类页双列表滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | contentEndOffset 为 0，保留原滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
| 材质关闭 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
### 我的页滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 尾部 padding 为 0，保留原滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
| 材质关闭 | 普通样式悬浮栏仍保留尾部避让 | 未验证 | 尚未实际验证 |
