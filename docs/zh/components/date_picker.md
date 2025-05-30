# DatePicker 日期选择器

用于选择日期的组件。

## 实现原理

使用 Flutter 的 DatePicker 组件进行封装,支持日期、日期范围、日期时间等多种选择模式。

## 基础用法

使用 `type` 属性来定义日期选择器的类型。

<CodeView
  codeUrl="datePicker/date_picker_basic.dart"
  reviewUrl="datePicker/basic"
  height="300px"
/>

## 不同尺寸

使用 `size` 属性来定义日期选择器的尺寸。

<CodeView
  codeUrl="datePicker/date_picker_size.dart"
  reviewUrl="datePicker/size"
  height="300px"
/>

## 日期格式

使用 `format` 属性来自定义日期的显示格式。

<CodeView
  codeUrl="datePicker/date_picker_format.dart"
  reviewUrl="datePicker/format"
  height="300px"
/>

## 禁用状态

使用 `disabled` 属性来控制日期选择器是否为禁用状态。

<CodeView
  codeUrl="datePicker/date_picker_disabled.dart"
  reviewUrl="datePicker/disabled"
  height="300px"
/>

## API

### DatePicker 属性

| 属性名      | 说明                                                     | 类型                | 默认值                      |
| ----------- | -------------------------------------------------------- | ------------------- | --------------------------- |
| type        | 日期选择器类型                                           | `DatePickerType`    | `DatePickerType.date`       |
| value       | 绑定值                                                   | `DateTime`          | -                           |
| placeholder | 非范围选择时的占位内容                                   | `String`            | -                           |
| size        | 输入框尺寸                                               | `ESizeItem`         | `ESizeItem.medium`          |
| disabled    | 是否禁用                                                 | `boolean`           | `false`                     |
| format      | 显示在输入框中的格式                                     | `String`            | `yyyy-MM-dd`                |
| onChange    | 用户确认选定的值时触发                                   | `Function`          | -                           |

### DatePickerType 枚举值

| 枚举值        | 说明           |
| ------------- | -------------- |
| date         | 日期选择       |
| daterange    | 日期范围选择   |
| datetime     | 日期时间选择   |
| datetimerange| 日期时间范围选择|

### DatePicker 事件

| 事件名    | 说明                 | 参数                     |
| --------- | -------------------- | ------------------------ |
| onChange  | 用户确认选定的值时触发 | `(DateTime date) => void` | 