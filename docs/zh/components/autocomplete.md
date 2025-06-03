# Autocomplete 自动补全输入框

带输入建议的输入框。

## 实现原理

使用 TextEditingController、FocusNode、OverlayEntry 等组件实现输入框和下拉建议列表，通过防抖机制优化性能。

## 基础用法

使用 `size` 属性来定义输入框的尺寸，`fetchSuggestions` 回调函数来获取建议数据。

`customHeight` 和 `customFontSize` 可以自定义输入框高度和字体大小，会覆盖 `size` 的设置。

<CodeView
  codeUrl="autocomplete_page/autocomplete_basic.dart"
  reviewUrl="autocomplete/basic"
  height="400px"
/>

## 自定义颜色

使用 `colorType` 属性来指定输入框的颜色类型，也可以通过 `customColor` 指定边框颜色。

`customColor` 会覆盖 `colorType` 的设置。

<CodeView
  codeUrl="autocomplete_page/autocomplete_color.dart"
  reviewUrl="autocomplete/color"
  height="300px"
/>

## 默认颜色

使用 `defaultColor` 属性来指定输入框的默认边框颜色。

<CodeView
  codeUrl="autocomplete_page/autocomplete_default_color.dart"
  reviewUrl="autocomplete/default-color"
  height="300px"
/>

## 可清除

使用 `clearable` 属性来控制是否显示清除按钮。

<CodeView
  codeUrl="autocomplete_page/autocomplete_clearable.dart"
  reviewUrl="autocomplete/clearable"
  height="300px"
/>

## 禁用状态

使用 `disabled` 属性来控制输入框是否为禁用状态。

<CodeView
  codeUrl="autocomplete_page/autocomplete_disable.dart"
  reviewUrl="autocomplete/disable"
  height="300px"
/>

## 占位符位置

使用 `showPlaceholderOnTop` 属性来指定聚焦时占位符是否显示在输入框顶部。

文字颜色同边框颜色一样受 `colorType` 和 `customColor` 影响。

<CodeView
  codeUrl="autocomplete_page/autocomplete_show_placeholder.dart"
  reviewUrl="autocomplete/showPlaceholder"
  height="300px"
/>

## 固定建议列表

使用组件的高级配置来实现更复杂的功能。

<CodeView
  codeUrl="autocomplete_page/autocomplete_fix.dart"
  reviewUrl="autocomplete/fix"
  height="400px"
/>

## API 调用

使用 `onFocus`、`onBlur`、`onChange`、`onSelect`、`onClear` 属性来定义输入框的回调函数。

<CodeView
  codeUrl="autocomplete_page/autocomplete_api.dart"
  reviewUrl="autocomplete/api"
  height="300px"
/>

## API

### Autocomplete 属性

| 属性名               | 说明                         | 类型                                                     | 默认值                    |
| -------------------- | ---------------------------- | -------------------------------------------------------- | ------------------------- |
| textController       | 文本控制器                   | `TextEditingController`                                  | -                         |
| placeholder          | 占位符文本                   | `String`                                                 | -                         |
| clearable            | 是否显示清除按钮             | `boolean`                                                | `false`                   |
| disabled             | 是否禁用                     | `boolean`                                                | `false`                   |
| valueKey             | 建议数据中作为显示值的字段名 | `String`                                                 | `'value'`                 |
| debounce             | 防抖延迟时间（毫秒）         | `int`                                                    | `300`                     |
| size                 | 输入框尺寸                   | `ESizeItem`                                              | `ESizeItem.medium`        |
| fetchSuggestions     | 获取建议数据的回调函数       | `Function(String, Function(List<Map<String, dynamic>>))` | 必需                      |
| triggerOnFocus       | 聚焦时是否触发建议搜索       | `boolean`                                                | `true`                    |
| hideLoading          | 是否隐藏加载指示器           | `boolean`                                                | `false`                   |
| highlightFirstItem   | 是否高亮第一项建议           | `boolean`                                                | `false`                   |
| fitInputWidth        | 建议列表是否适配输入框宽度   | `boolean`                                                | `false`                   |
| prefix               | 输入框前缀图标               | `Widget`                                                 | -                         |
| suffix               | 输入框后缀图标               | `Widget`                                                 | -                         |
| prepend              | 输入框前置元素               | `Widget`                                                 | -                         |
| append               | 输入框后置元素               | `Widget`                                                 | -                         |
| loading              | 自定义加载组件               | `Widget`                                                 | -                         |
| colorType            | 颜色类型                     | `EColorType`                                             | `EColorType.primary`      |
| customColor          | 自定义颜色                   | `Color`                                                  | -                         |
| defaultColor         | 默认边框颜色                 | `Color`                                                  | `EBasicColors.borderGray` |
| customHeight         | 自定义输入框高度             | `double`                                                 | -                         |
| customFontSize       | 自定义字体大小               | `double`                                                 | -                         |
| customBorderRadius   | 自定义边框圆角               | `double`                                                 | -                         |
| showPlaceholderOnTop | 聚焦时占位符是否显示在顶部   | `boolean`                                                | `false`                   |

### Autocomplete 事件

| 事件名   | 说明               | 参数                      |
| -------- | ------------------ | ------------------------- |
| onSelect | 选择建议项时触发   | `(dynamic value) => void` |
| onChange | 输入内容变化时触发 | `(String value) => void`  |
| onFocus  | 获得焦点时触发     | `() => void`              |
| onBlur   | 失去焦点时触发     | `() => void`              |
| onClear  | 清除内容时触发     | `() => void`              |
