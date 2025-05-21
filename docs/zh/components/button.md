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
  codeUrl="button_page/button_icon.dart"
  reviewUrl="button/icon"
  height="300px"
/>

## 链接按钮

使用 `link` 属性来定义链接按钮。

<CodeView
  codeUrl="button_page/button_link.dart"
  reviewUrl="button/link"
  height="300px"
/>

## 加载状态

使用 `loading` 属性来显示加载状态。

<CodeView
  codeUrl="button_page/button_loading.dart"
  reviewUrl="button/loading"
  height="300px"
/>

## 按钮尺寸

使用 `size` 属性来定义按钮的尺寸。

<CodeView
  codeUrl="button_page/button_size.dart"
  reviewUrl="button/size"
  height="300px"
/>

## 自定义颜色

使用 `color` 属性来自定义按钮的颜色。

<CodeView
  codeUrl="button_page/button_custom_color.dart"
  reviewUrl="button/custom-color"
  height="300px"
/>

## 自定义内容

使用 `child` 属性来自定义按钮的内容。

<CodeView
  codeUrl="button_page/button_custom_children.dart"
  reviewUrl="button/custom-children"
  height="300px"
/>

## api 调用

<CodeView
  codeUrl="button_page/button_api.dart"
  reviewUrl="button/api"
  height="300px"
/>

## API

### Button 属性

| 属性名     | 说明                                               | 类型                | 默认值                      |
| ---------- | -------------------------------------------------- | ------------------- | --------------------------- |
| text       | 按钮文字                                           | `String`            | -                           |
| type       | 按钮类型                                           | `ElementButtonType` | `ElementButtonType.default` |
| size       | 按钮尺寸                                           | `ElementButtonSize` | `ElementButtonSize.medium`  |
| fontSize   | 自定义按钮文字大小, 按钮尺寸会根据文字大小自动调整 | `double`            | -                           |
| color      | 自定义背景颜色，文字颜色会根据背景颜色自动计算     | `Color`             | -                           |
| link       | 是否为链接按钮                                     | `boolean`           | `false`                     |
| icon       | 图标                                               | `Widget`            | -                           |
| child      | 自定义按钮内容，会覆盖 Icon 和 Text，优先级最高    | `Widget`            | -                           |
| isPlain    | 是否为朴素按钮                                     | `boolean`           | `false`                     |
| isRound    | 是否为圆角按钮                                     | `boolean`           | `false`                     |
| loading    | 是否为加载中状态                                   | `boolean`           | `false`                     |
| isDisabled | 是否禁用按钮                                       | `boolean`           | `false`                     |

### Button 事件

| 事件名        | 说明                                                                   | 参数                     |
| ------------- | ---------------------------------------------------------------------- | ------------------------ |
| onPressed     | 点击按钮时触发                                                         | `() => void`             |
| onHover       | 鼠标悬停时触发, 鼠标进入时返回 true, 离开时返回 false，只在 web 端有效 | `(bool isHover) => void` |
| onLongPressed | 长按按钮时触发                                                         | `() => void`             |
