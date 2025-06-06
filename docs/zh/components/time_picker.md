# TimePicker 时间选择器

用于选择或输入日期时间的组件。

## 实现原理

使用 `ETimePicker` 组件实现，内部通过 `Overlay` 和 `ListWheelScrollView` 实现时间选择的下拉面板。

## 基础用法

使用 `value` 和 `onChange` 属性来定义时间选择器的值和回调函数。

<CodeView
  codeUrl="time_picker_page/time_picker_basic.dart"
  reviewUrl="time_picker/basic"
  height="300px"
/>

## 时间格式

使用 `use24HourFormat` 属性来控制是否使用 24 小时制。

<CodeView
  codeUrl="time_picker_page/time_picker_format.dart"
  reviewUrl="time_picker/format"
  height="300px"
/>

## 只读状态

使用 `readOnly` 属性来控制时间选择器是否为只读状态。

<CodeView
  codeUrl="time_picker_page/time_picker_readonly.dart"
  reviewUrl="time_picker/readonly"
  height="300px"
/>

## API

### TimePicker 属性

| 属性名               | 说明                           | 类型                       | 默认值                    |
| -------------------- | ------------------------------ | -------------------------- | ------------------------- |
| value                | 当前选中的时间                 | `DateTime?`                | -                         |
| onChange             | 选中时间变化时的回调           | `ValueChanged<TimeOfDay>?` | -                         |
| placeholder          | 输入框占位文本                 | `String?`                  | '请选择时间'              |
| prefix               | 输入框前缀图标                 | `Widget?`                  | 时钟图标                  |
| size                 | 输入框尺寸                     | `ESizeItem`                | `ESizeItem.medium`        |
| disabled             | 是否禁用                       | `boolean`                  | `false`                   |
| readOnly             | 是否只读                       | `boolean`                  | `false`                   |
| clearable            | 是否可清空                     | `boolean`                  | `false`                   |
| colorType            | 输入框颜色类型                 | `EColorType`               | `EColorType.primary`      |
| customColor          | 自定义颜色                     | `Color?`                   | -                         |
| defaultColor         | 默认边框颜色                   | `Color`                    | `EBasicColors.borderGray` |
| customHeight         | 自定义高度                     | `double?`                  | -                         |
| customFontSize       | 自定义字体大小                 | `double?`                  | -                         |
| customBorderRadius   | 自定义圆角                     | `double?`                  | -                         |
| showPlaceholderOnTop | 是否在聚焦时显示占位文本在上方 | `boolean`                  | `false`                   |
| use24HourFormat      | 是否使用 24 小时制             | `boolean`                  | `true`                    |

### TimePicker 事件

| 事件名   | 说明                 | 参数             |
| -------- | -------------------- | ---------------- |
| onChange | 选中时间变化时触发   | `TimeOfDay time` |
| onFocus  | 输入框获得焦点时触发 | `() => void`     |
| onBlur   | 输入框失去焦点时触发 | `() => void`     |
| onClear  | 点击清空按钮时触发   | `() => void`     |
