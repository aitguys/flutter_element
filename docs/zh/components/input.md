# Input 输入框

通过鼠标或键盘输入字符。

## 实现原理

使用 TextField 组件作为基础，通过 Container、Stack 等组件实现自定义样式和交互效果。

## 基础用法

使用 `size` 属性来定义输入框的尺寸。

<CodeView
  codeUrl="input_page/input_basic.dart"
  reviewUrl="input/basic"
  height="200px"
/>

## 禁用状态

使用 `disabled`、`readOnly` 和 `nonEditable` 属性来定义输入框是否为禁用状态，在样式展示上有些微区别：
- `disabled`: 禁用输入，背景色变为灰色，边框颜色不变
- `readOnly`: 只读，可以聚焦但不可编辑，边框颜色变为浅灰色
- `nonEditable`: 禁止输入但不改变样式，保持原有的背景色和边框颜色

<CodeView
  codeUrl="input_page/input_disable.dart"
  reviewUrl="input/disable"
  height="200px"
/>

## 可清空

使用 `clearable` 属性来定义输入框是否可清空。

<CodeView
  codeUrl="input_page/input_clearable.dart"
  reviewUrl="input/clearable"
  height="200px"
/>

## 自定义颜色

使用 `colorType` 和 `customColor` 属性来自定义输入框的颜色。

<CodeView
  codeUrl="input_page/input_color.dart"
  reviewUrl="input/color"
  height="200px"
/>

## 默认颜色

使用 `defaultColor` 属性来定义输入框的默认边框颜色。

<CodeView
  codeUrl="input_page/input_defaultColor.dart"
  reviewUrl="input/defaultColor"
  height="200px"
/>

## 占位符样式

使用 `showPlaceholderOnTop` 属性来控制占位符的显示样式。

<CodeView
  codeUrl="input_page/input_showPlaceholder.dart"
  reviewUrl="input/showPlaceholder"
  height="200px"
/>

## 是否显示为密码

使用 password 控制是否显示为密码

<CodeView
  codeUrl="input_page/input_password.dart"
  reviewUrl="input/password"
  height="200px"
/>

## 前缀和后缀

使用 `prefix` 和 `suffix` 属性来定义输入框的前缀和后缀。

<CodeView
  codeUrl="input_page/input_fix.dart"
  reviewUrl="input/fix"
  height="200px"
/>

## API

input 组件提供 onFocus, onBlur， onChanged 事件， 可以监听输入框的聚焦、失焦、输入内容变化时的回调。

<CodeView
  codeUrl="input_page/input_api.dart"
  reviewUrl="input/api"
  height="200px"
/>

### Input 属性

| 属性名               | 说明                 | 类型                    | 默认值                    |
| -------------------- | -------------------- | ----------------------- | ------------------------- |
| textController       | 输入框控制器         | `TextEditingController` | -                         |
| placeholder          | 输入框占位文本       | `String`                | ''                        |
| clearable            | 是否可清空           | `boolean`               | `false`                   |
| disabled             | 是否禁用             | `boolean`               | `false`                   |
| passowrd             | 是否为密码           | `boolean`               | `false`                   |
| readOnly             | 是否只读             | `boolean`               | `false`                   |
| nonEditable          | 禁止输入但不改变样式 | `boolean`               | `false`                   |
| prefix               | 输入框前缀           | `Widget`                | -                         |
| suffix               | 输入框后缀           | `Widget`                | -                         |
| colorType            | 输入框颜色类型       | `EColorType`            | `EColorType.primary`      |
| customColor          | 自定义颜色           | `Color`                 | -                         |
| borderColor         | 默认边框颜色         | `Color`                 | `EBasicColors.borderGray` |
| size                 | 输入框尺寸           | `ESizeItem`             | `ESizeItem.medium`        |
| customHeight         | 自定义高度           | `double`                | -                         |
| customFontSize       | 自定义字体大小       | `double`                | -                         |
| customBorderRadius   | 自定义圆角大小       | `double`                | -                         |
| showPlaceholderOnTop | 是否在顶部显示占位符 | `boolean`               | `false`                   |

### Input 事件

| 事件名    | 说明                 | 参数                     |
| --------- | -------------------- | ------------------------ |
| onChanged | 输入框内容变化时触发 | `(String value) => void` |
| onFocus   | 输入框获得焦点时触发 | `() => void`             |
| onBlur    | 输入框失去焦点时触发 | `() => void`             |

</rewritten_file>
