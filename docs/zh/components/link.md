# Link 链接

文字超链接，用于跳转或者触发事件。

## 实现原理

使用 MouseRegion 嵌套 GestureDetector、Text 等组件实现链接样式和交互效果。

## 基础用法

使用 `type` 属性来定义链接的类型。

<CodeView
  codeUrl="link_page/link_basic.dart"
  reviewUrl="link/basic"
  height="100px"
/>

## 禁用状态

使用 `disabled` 属性来控制链接是否为禁用状态。

<CodeView
  codeUrl="link_page/link_disabled.dart"
  reviewUrl="link/disabled"
  height="100px"
/>

## 下划线

使用 `underline` 属性来控制链接是否显示下划线。

<CodeView
  codeUrl="link_page/link_underline.dart"
  reviewUrl="link/underline"
  height="100px"
/>

## 图标链接

使用 `icon` 属性来为链接添加图标。

<CodeView
  codeUrl="link_page/link_icon.dart"
  reviewUrl="link/icon"
  height="100px"
/>

## 链接属性

使用 `href` 和 `target` 属性来定义链接的跳转行为。

<CodeView
  codeUrl="link_page/link_href.dart"
  reviewUrl="link/href"
  height="100px"
/>

## 路由跳转

使用 `route` 属性来实现应用内路由跳转。

<CodeView
  codeUrl="link_page/route.dart"
  reviewUrl="link/route"
  height="100px"
/>

## API

### Link 属性

| 属性名    | 说明             | 类型         | 默认值               |
| --------- | ---------------- | ------------ | -------------------- |
| text      | 链接文字         | `String`     | -                    |
| type      | 链接类型         | `EColorType` | `EColorType.default` |
| disabled  | 是否禁用状态     | `boolean`    | `false`              |
| underline | 是否显示下划线   | `boolean`    | `true`               |
| icon      | 图标             | `Widget`     | -                    |
| href      | 原生链接地址     | `String`     | -                    |
| target    | 原生链接打开方式 | `String`     | -                    |
| route     | 应用内路由地址   | `String`     | -                    |

### Link 事件

| 事件名    | 说明           | 参数                     |
| --------- | -------------- | ------------------------ |
| onPressed | 点击链接时触发 | `() => void`             |
| onHover   | 鼠标悬停时触发 | `(bool isHover) => void` |
