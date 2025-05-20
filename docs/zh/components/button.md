# Button 按钮

常用的操作按钮。

## 基础用法

使用 `type`、`plain`、`round` 和 `circle` 属性来定义按钮的样式。

<CodeView
  codeUrl="button_page/button_basic.dart"
  reviewUrl="button/basic"
  height="300px"
/>


## 禁用状态

使用 `disabled` 属性来控制按钮是否为禁用状态。

<CodeView
  codeUrl="button_page/button_disable.dart"
  reviewUrl="button/disable"
  height="300px"
/>

## 图标按钮

使用 `icon` 属性来为按钮添加图标。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_icon.dart"
  reviewUrl="http://localhost:59886/#/button/icon"
  height="300px"
/>

## 文字按钮

没有边框和背景色的按钮。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_text.dart"
  reviewUrl="http://localhost:59886/#/button/text"
  height="300px"
/>

## 链接按钮

使用 `link` 属性来定义链接按钮。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_link.dart"
  reviewUrl="http://localhost:59886/#/button/link"
  height="300px"
/>

## 加载状态

使用 `loading` 属性来显示加载状态。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_loading.dart"
  reviewUrl="http://localhost:59886/#/button/loading"
  height="300px"
/>

## 按钮尺寸

使用 `size` 属性来定义按钮的尺寸。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_size.dart"
  reviewUrl="http://localhost:59886/#/button/size"
  height="300px"
/>

## 自定义颜色

使用 `color` 属性来自定义按钮的颜色。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_custom_color.dart"
  reviewUrl="http://localhost:59886/#/button/custom-color"
  height="300px"
/>

## 徽章按钮

使用 `badge` 属性来为按钮添加徽章。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_badge.dart"
  reviewUrl="http://localhost:59886/#/button/badge"
  height="300px"
/>

## 自定义内容

使用 `child` 属性来自定义按钮的内容。

<CodeView
  codeUrl="https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/button_page/button_custom_children.dart"
  reviewUrl="http://localhost:59886/#/button/custom-children"
  height="300px"
/>

## API

### Button 属性

| 属性名 | 说明 | 类型 | 默认值 |
|--------|------|------|--------|
| type | 按钮类型 | `ElementButtonType` | `ElementButtonType.default` |
| size | 按钮尺寸 | `ElementButtonSize` | `ElementButtonSize.medium` |
| plain | 是否为朴素按钮 | `boolean` | `false` |
| round | 是否为圆角按钮 | `boolean` | `false` |
| circle | 是否为圆形按钮 | `boolean` | `false` |
| loading | 是否为加载中状态 | `boolean` | `false` |
| disabled | 是否禁用按钮 | `boolean` | `false` |
| icon | 图标组件 | `Widget` | - |
| text | 是否为文字按钮 | `boolean` | `false` |
| link | 是否为链接按钮 | `boolean` | `false` |
| color | 自定义按钮颜色 | `Color` | - |
| badge | 徽章配置 | `ElementBadgeProps` | - |

### Button 事件

| 事件名 | 说明 | 参数 |
|--------|------|------|
| onPressed | 点击按钮时触发 | `() => void` |

### Button 插槽

| 插槽名 | 说明 |
|--------|------|
| default | 按钮内容 |
| icon | 自定义图标 |
