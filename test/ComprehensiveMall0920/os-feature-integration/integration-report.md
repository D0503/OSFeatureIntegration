# 平行视界接入汇总报告

工程：D:\HW\testproject\osfeaturetest\ComprehensiveMall0920

## 平行视界改造汇总

以下为已实施的代码配置；实际效果以逐项验证结果为准。

| 改造项 | 页面 / 组件 | 已实施配置 | 修改文件 | 运行验证 | 视觉验证 |
|---|---|---|---|---|---|
| entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage | 全局（entry 应用级 easyGo 配置） / Navigation | entry 模块新增 easyGo 配置：wideWindowMode 与 squareWindowMode 均为 navigationSplit，navigationSplitOptions 配置 homePage=MainEntry、relatedPage=ProductInfoPage、mode=0（购物模式，API 26 增强字段）；纯配置接入未修改任何 .ets 源码，宽屏/方形窗口分栏行为与回退待真机验证 | products/entry/src/main/module.json5<br>products/entry/src/main/resources/base/profile/easy&#95;go.json | 未验证 | 未验证 |

## 路线与模式

| 目标 | 技术路线 | 类别 |
|---|---|---|
| entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage | Navigation | 购物模式 |

## 视觉验证结果

### entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage

页面 / 组件：全局（entry 应用级 easyGo 配置） / Navigation。

视觉结果：**未验证**。未完成目标页视觉验证：未请求安装运行

设备：未指定；系统：未采集。

验证时间：2026-09-20T08:00:16.409Z；整体结果：未确认。

| 验证阶段 | 结果 | 说明 |
|---|---|---|
| 静态检查 | 通过 | 静态检查通过，warn 项已全部复核 |
| SDK | 通过 | 本机 SDK API 26，navigation 路线可用 |
| 构建 | 通过 | ohpm、Hvigor 同步与打包通过 |
| 安装启动 | 未验证 | 未请求安装运行 |
| 目标页导航 | 未验证 | 应用未成功安装启动 |
| 运行观察 | 未验证 | 未完成目标页验证：应用未成功安装启动 |

静态复核结论：

- 已复核通过：关联页不能接收动态参数，需确认可独立初始化；位置：products/entry/src/main/resources/base/profile/easy&#95;go.json；ProductInfoPage（features/product/src/main/ets/views/ProductInfoPage.ets）onReady 中 params 为 undefined 时不调用 initData；build 中 !vm.productInfo 分支渲染 buildEmptySearch() 空态占位，无参可独立初始化不崩溃，属既有行为。
- 已复核通过：MainEntry：未解析到字面量名称，需核对动态路由/常量映射；位置：products/entry/src/main/resources/base/profile/easy&#95;go.json；MainEntry 注册于 products/entry/src/main/resources/base/profile/route&#95;map.json（name=MainEntry，views/MainEntry.ets build 为 NavDestination）；ProductInfoPage 注册于 features/product/src/main/resources/base/profile/route&#95;map.json（name=ProductInfoPage，views/ProductInfoPage.ets build 为 NavDestination）；两者均为全局路由表聚合的有效 NavDestination 名称。
- 已复核通过：ProductInfoPage：未解析到字面量名称，需核对动态路由/常量映射；位置：products/entry/src/main/resources/base/profile/easy&#95;go.json；MainEntry 注册于 products/entry/src/main/resources/base/profile/route&#95;map.json（name=MainEntry，views/MainEntry.ets build 为 NavDestination）；ProductInfoPage 注册于 features/product/src/main/resources/base/profile/route&#95;map.json（name=ProductInfoPage，views/ProductInfoPage.ets build 为 NavDestination）；两者均为全局路由表聚合的有效 NavDestination 名称。

## 升级与兼容

SDK 版本与回退行为按整个工程记录一份；保留行为覆盖所有改造项。

| 项目 | 改造前 | 改造后 |
|---|---|---|
| 本机 SDK API | 26 | 26 |
| compile API | 26 | 26 |
| target API | 24 | 24 |
| 最低兼容 API | 23 | 23 |

SDK/API 未升级。

| 回退条件 | 保留行为 | 验证结果 | 证据或限制 |
|---|---|---|---|
| 低版本 | entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage：API 低于 26 的设备忽略 mode 字段按系统默认分栏行为；API 低于 23 不具备 easyGo 配置能力，保持原 Navigation Stack 单栏路径，源码零改动原路径保留 | 未验证 | 尚未实际验证 |
| 设备不支持 | entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage：窗口宽度不足 600vp 或长宽比不满足宽屏/方形条件、自由多窗场景时，系统保持 original 单栏布局，不清空路由栈、不重置状态 | 未验证 | 尚未实际验证 |
| 特性关闭 | entry 模块接入平行视界：navigation 路线购物模式，homePage=MainEntry，relatedPage=ProductInfoPage：系统平行视界开关关闭或窗口显示模式为 original 时，回到接入前应用体验，页面栈、参数与业务行为不变 | 未验证 | 尚未实际验证 |
