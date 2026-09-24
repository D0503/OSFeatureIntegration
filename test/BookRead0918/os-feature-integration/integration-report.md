# 沉浸光感接入汇总报告

工程：D:\HW\testproject\osfeaturetest\BookRead0918

## 沉浸光感改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| 应用级材质开启 | 应用级配置 / MaterialState | entry module 配置 ohos.arkui.UIMaterial.state=enable，Toast/Menu/Dialog/Sheet 由系统默认材质覆盖，具体生效待运行验证 | entry/src/main/module.json5 | 未验证 | 未验证 |
| targetSdk升级26 | 工程配置 / build-profile | targetSdkVersion 由 6.0.2(22) 升级为 26.0.0，compatibleSdkVersion 保持 6.0.0(20) 不变 | build-profile.json5 | 未验证 | 未验证 |
| 书架页滚动尾部避让 | 书架页 / Scroll/Grid | 书架页滚动内容末尾 padding 由固定 15 改为悬浮分支 15+84（删除模式不补偿），末项可滚出悬浮栏待运行验证 | feature/book&#95;shelf/src/main/ets/views/BookShelfPage.ets<br>commons/common/src/main/ets/constant/Constants.ets | 未验证 | 未验证 |
| 书城页滚动尾部避让 | 书城页 / List | 书城页主 List 增加 contentEndOffset(悬浮分支 84，否则 0)，末项可滚出悬浮栏待运行验证 | feature/book&#95;home/src/main/ets/views/BookListPage.ets<br>commons/common/src/main/ets/constant/Constants.ets | 未验证 | 未验证 |
| 分类页滚动尾部避让 | 分类页 / List | 分类页左侧分类 List 与右侧内容 List 均增加 contentEndOffset(悬浮分支 84，否则 0)，末项可滚出悬浮栏待运行验证 | feature/book&#95;sort/src/main/ets/pages/BookSortPage.ets<br>commons/common/src/main/ets/constant/Constants.ets | 未验证 | 未验证 |
| 我的页滚动尾部避让 | 我的页 / Scroll | 我的页 Scroll 内容 Column 末尾增加 padding(悬浮分支 84，否则 0)，末项可滚出悬浮栏待运行验证 | feature/book&#95;person/src/main/ets/views/PersonPage.ets<br>commons/common/src/main/ets/constant/Constants.ets | 未验证 | 未验证 |
| 首页底部Tabs悬浮材质 | 首页 / Tabs | API26+ 分支配置 barOverlap(true)+vertical(false)+BarPosition.End+barFloatingStyle(barBottomMargin 28, adaptToHandedness)，使用系统默认 THIN 材质；低版本分支保留原断点侧栏布局 | entry/src/main/ets/pages/BookHomePage.ets<br>commons/common/src/main/ets/constant/Constants.ets | 未确认 | 未确认 |

## 沉浸光感类别

| 目标 | 技术路线 | 类别 |
|---|---|---|
| 应用级材质开启 | ArkUI | 应用级材质（Toast THICK / Menu THICK / Dialog・Sheet ULTRA&#95;THICK 系统默认） |
| targetSdk升级26 | ArkUI | 升级配置（ArkUI 路线门禁 target&#62;=26，compatible 保持 20） |
| 书架页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 书城页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 分类页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 我的页滚动尾部避让 | ArkUI | 滚动尾部避让 |
| 首页底部Tabs悬浮材质 | ArkUI | 悬浮 Tab（底部悬浮 TabBar，系统默认 THIN 材质） |

## 视觉验证结果

### 应用级材质开启

页面 / 组件：应用级配置 / MaterialState。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:19:27.714Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### targetSdk升级26

页面 / 组件：工程配置 / build-profile。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:19:32.692Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### 书架页滚动尾部避让

页面 / 组件：书架页 / Scroll/Grid。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:19:45.035Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### 书城页滚动尾部避让

页面 / 组件：书城页 / List。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:19:50.157Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### 分类页滚动尾部避让

页面 / 组件：分类页 / List。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:19:55.445Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### 我的页滚动尾部避让

页面 / 组件：我的页 / Scroll。

视觉结果：**未验证**。未完成目标页视觉验证：未请求构建

设备：未指定；系统：未采集。

验证时间：2026-09-18T04:20:00.641Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 未验证 | 未请求构建 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。
### 首页底部Tabs悬浮材质

页面 / 组件：首页 / Tabs。

视觉结果：**未确认**。目标页截图已采集并存于 evidence/2b0f0a037d66f1a7119ac73cd6ea8c9012dbfcc0fd3d29d4a94dfd5af45ff963.png，但本轮证据阅读工具不支持图片输入，无法判读悬浮 TabBar 材质观感（THIN 毛玻璃效果、深浅色、系统档位），视觉结论保持未确认，需人工查看截图复核。

设备：华为畅享 90 Pro Max；系统：API 26 (Release)。

验证时间：2026-09-18T06:16:42.335Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 未确认 | 待处理项目见下方，扫描提示不等于已确认缺陷 |
| SDK | 通过 | 本机 SDK API 26，arkui 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 通过 | 应用已安装并启动 |
| 目标页导航 | 通过 | 导航完成，目标页面断言通过 |
| 运行观察 | 未确认 | 真机（华为畅享 90 Pro Max，API 26）完成安装启动并成功导航至主页：组件树包含书架/书城/分类/我的四个页签及书架页内容，悬浮分支按 sdkApiVersion&#62;=26 门禁启用。各一级页滚动开始、内容经过栏下、滚到末尾与末项操作，以及低版本/不支持/禁用回退分支未逐项执行，保持未确认。 |

待处理事项：

- 待核对：沿调用链核对新增 API 的低版本保护；位置：entry/src/main/ets/pages/BookHomePage.ets:31。
- 待核对：核对标题栏下方的内容延伸布局；位置：components/aggregated&#95;ads/src/main/ets/components/AdServicePage.ets:33、components/aggregated&#95;payment/src/main/ets/components/AggregatedPaymentPicker.ets:92、components/incentive&#95;ad/src/main/ets/components/IncentiveAdvertising.ets:39。
- 待核对：核对 Tab 栏背景色或模糊是否遮挡材质；位置：entry/src/main/ets/pages/BookHomePage.ets:107、feature/book&#95;person/src/main/ets/views/LibraryPage.ets:72。
- 待核对：核对悬浮栏宽度与各断点布局；位置：entry/src/main/ets/pages/BookHomePage.ets:130、entry/src/main/ets/pages/BookHomePage.ets:129、feature/book&#95;person/src/main/ets/views/MyDownloadPage.ets:169。
- 待核对：核对窗口沉浸状态、栏底距与完整安全区扩展链；位置：commons/common/src/main/ets/utils/WindowUtils.ets:15、components/aggregated&#95;share/src/main/ets/model/ShareConfigModel.ets:74、components/aggregated&#95;share/src/main/ets/SharePicker.ets:41。
- 待核对：核对外层底部 padding 的用途与分支归属；位置：entry/src/main/ets/pages/BookHomePage.ets:107、entry/src/main/ets/pages/BookHomePage.ets:92、commons/common/src/main/ets/comp/Toast.ets:47。
- 待核对：逐页验证真实滚动容器的尾部补偿和末项操作；位置：commons/common/src/main/ets/ui/BookCard.ets:278、commons/common/src/main/ets/ui/BookCard.ets:460、components/aggregated&#95;share/src/main/ets/components/PosterSharePanel.ets:40。

![目标页面截图](<evidence/2b0f0a037d66f1a7119ac73cd6ea8c9012dbfcc0fd3d29d4a94dfd5af45ff963.png>)


## 升级与兼容

### 应用级材质开启

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | 低版本系统不解析该 metadata，行为与未配置一致，保留普通样式 | 不适用 | metadata 仅 API26+ 系统识别，低版本设备保留接入前状态 |
| 设备不支持 | 设备不支持材质时默认材质无效果，Toast/Menu/Dialog 保留普通样式 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 DISABLE 时全部默认材质关闭，保留普通样式 | 未验证 | 尚未实际验证 |
### targetSdk升级26

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | compatibleSdkVersion 保持 20，低版本设备可安装运行，新增 API 经 sdkApiVersion 组件树分支保护 | 未验证 | 尚未实际验证 |
| 设备不支持 | 不涉及设备能力判断，not&#95;applicable | 不适用 | 纯构建配置项，无设备能力分支 |
| 材质关闭 | 不涉及材质开关，not&#95;applicable | 不适用 | 纯构建配置项，无材质开关分支 |
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
| 低版本 | useFloatingTab=false 时保持原 padding 15，滚动范围与源程序一致 | 未验证 | 尚未实际验证 |
| 设备不支持 | 材质不支持设备仍为悬浮重叠布局，补偿 padding 同样保留以防末项遮挡 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质关闭仍为底部横向布局，补偿保留 | 未验证 | 尚未实际验证 |
### 书城页滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | useFloatingTab=false 时 contentEndOffset=0，滚动范围与源程序一致 | 未验证 | 尚未实际验证 |
| 设备不支持 | 材质不支持设备仍为悬浮重叠布局，补偿同样保留 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质关闭仍为底部横向布局，补偿保留 | 未验证 | 尚未实际验证 |
### 分类页滚动尾部避让

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | useFloatingTab=false 时 contentEndOffset=0，滚动范围与源程序一致 | 未验证 | 尚未实际验证 |
| 设备不支持 | 材质不支持设备仍为悬浮重叠布局，补偿同样保留 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质关闭仍为底部横向布局，补偿保留 | 未验证 | 尚未实际验证 |
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
| 低版本 | useFloatingTab=false 时不加补偿 padding，保持源程序滚动范围 | 未验证 | 尚未实际验证 |
| 设备不支持 | 材质不支持设备仍为悬浮重叠布局，补偿同样保留 | 未验证 | 尚未实际验证 |
| 材质关闭 | 材质关闭仍为底部横向布局，补偿保留 | 未验证 | 尚未实际验证 |
### 首页底部Tabs悬浮材质

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 22 | 26 |
| 最低兼容 API | 20 | 20 |

SDK/API 变更如上表。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | sdkApiVersion&#60;26 时走原 Tabs 组件树，保留断点侧栏/barWidth96/padding18 原布局与交互 | 未验证 | 尚未实际验证 |
| 设备不支持 | 材质不支持设备保留底部横向悬浮布局，材质自动无效果不报错 | 未验证 | 尚未实际验证 |
| 材质关闭 | 应用级 DISABLE 时材质不生效，悬浮布局与普通样式保留 | 未验证 | 尚未实际验证 |
