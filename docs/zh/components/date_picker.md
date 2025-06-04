# DatePicker 日期选择器

用于选择日期的组件。

## 实现原理

使用 `EDatePicker` 组件封装了 `EInput` 和 `Calendar` 组件，通过 `Overlay` 实现弹出层效果。

## 基础用法

使用 `type` 属性来定义日期选择器的类型，支持日期、月份、年份的选择。

<CodeView
  codeUrl="datePicker/date_picker_basic.dart"
  reviewUrl="datePicker/basic"
  height="300px"
/>

## 多选用法

使用 `type` 属性设置为 `dates`、`months`、`years` 来实现多选功能。

<CodeView
  codeUrl="datePicker/date_picker_multiple.dart"
  reviewUrl="datePicker/multiple"
  height="300px"
/>

## 日期范围限制

使用 `minDate` 和 `maxDate` 属性来限制可选日期的范围。

<CodeView
  codeUrl="datePicker/date_picker_range.dart"
  reviewUrl="datePicker/range"
  height="300px"
/>

## 默认值设置

使用 `value` 属性来设置日期选择器的默认值。

<CodeView
  codeUrl="datePicker/date_picker_default.dart"
  reviewUrl="datePicker/default"
  height="300px"
/>

## 样式设置

使用 `size`、`colorType`、`customColor`、`defaultColor`、`customHeight`、`customFontSize`、`customBorderRadius` 等属性来自定义日期选择器的样式。

<CodeView
  codeUrl="datePicker/date_picker_style.dart"
  reviewUrl="datePicker/style"
  height="300px"
/>

## 日期格式

使用 `format` 属性来自定义日期的显示格式。

<CodeView
  codeUrl="datePicker/date_picker_format.dart"
  reviewUrl="datePicker/format"
  height="300px"
/>

## 日历组件

除了使用 `EDatePicker` 组件外，还可以直接使用 `Calendar` 组件来实现日期选择功能。

<CodeView
  codeUrl="datePicker/date_picker_calendar.dart"
  reviewUrl="datePicker/calendar"
  height="300px"
/>

## API

### EDatePicker 属性

| 属性名             | 说明                                     | 类型           | 默认值                    |
| ------------------ | ---------------------------------------- | -------------- | ------------------------- |
| value              | 当前选中的日期值                         | `String?`      | -                         |
| format             | 日期格式                                 | `String?`      | -                         |
| type               | 日期选择器类型                           | `CalendarType` | `CalendarType.date`       |
| minDate            | 可选的最小日期                           | `DateTime?`    | -                         |
| maxDate            | 可选的最大日期                           | `DateTime?`    | -                         |
| weekDate           | 是否显示周视图，仅在 type 为 date 时有效 | `bool`         | `false`                   |
| placeholder        | 占位文本                                 | `String`       | '选择日期'                |
| disabled           | 是否禁用                                 | `bool`         | `false`                   |
| clearable          | 是否可清空                               | `bool`         | `true`                    |
| size               | 尺寸大小                                 | `ESizeItem`    | `ESizeItem.medium`        |
| prefix             | 前缀图标                                 | `Widget?`      | -                         |
| suffix             | 后缀图标                                 | `Widget?`      | -                         |
| colorType          | 颜色类型                                 | `EColorType`   | `EColorType.primary`      |
| customColor        | 自定义颜色                               | `Color?`       | -                         |
| defaultColor       | 默认颜色                                 | `Color`        | `EBasicColors.borderGray` |
| customHeight       | 自定义高度                               | `double?`      | -                         |
| customFontSize     | 自定义字体大小                           | `double?`      | -                         |
| customBorderRadius | 自定义圆角大小                           | `double?`      | -                         |

### Calendar 属性

| 属性名      | 说明           | 类型           | 默认值              |
| ----------- | -------------- | -------------- | ------------------- |
| initialDate | 初始日期值     | `String?`      | -                   |
| type        | 日历类型       | `CalendarType` | `CalendarType.date` |
| minDate     | 可选的最小日期 | `DateTime?`    | -                   |
| maxDate     | 可选的最大日期 | `DateTime?`    | -                   |
| format      | 日期格式       | `String?`      | -                   |
| weekDate    | 是否显示周视图 | `bool`         | `false`             |
| prevMonth   | 上个月按钮     | `Widget?`      | -                   |
| nextMonth   | 下个月按钮     | `Widget?`      | -                   |
| prevYear    | 上一年按钮     | `Widget?`      | -                   |
| nextYear    | 下一年按钮     | `Widget?`      | -                   |

### 事件

| 事件名   | 说明                 | 参数                    |
| -------- | -------------------- | ----------------------- |
| onSelect | 选择日期时的回调函数 | `ValueChanged<String?>` |

### CalendarType 类型

| 类型   | 说明     |
| ------ | -------- |
| date   | 日期     |
| dates  | 多个日期 |
| month  | 月份     |
| year   | 年份     |
| months | 多个月份 |
| years  | 多个年份 |
