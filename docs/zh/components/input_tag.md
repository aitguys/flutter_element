# InputTag 标签输入框

用于输入和管理多个标签。

## 实现原理

基于 TextField 实现，结合标签渲染、增删、事件回调等功能。

## 自定义 tag 样式

通过 `tagBuilder` 属性自定义标签的渲染样式。

<CodeView
  codeUrl="inputTag/input_tag_custom_tag.dart"
  reviewUrl="inputTag/custom-tag"
  height="300px"
/>

## 自定义 prefix 和 suffix

通过 `prefix` 和 `suffix` 属性自定义输入框前后缀。

<CodeView
  codeUrl="inputTag/input_tag_prefix_suffix.dart"
  reviewUrl="inputTag/prefix-suffix"
  height="300px"
/>

## 最大标签数量

通过 `max` 属性限制可输入的标签数量。

<CodeView
  codeUrl="inputTag/input_tag_max.dart"
  reviewUrl="inputTag/max"
  height="300px"
/>

## 分隔符

通过 `delimiter` 属性自定义分隔符。

<CodeView
  codeUrl="inputTag/input_tag_delimiter.dart"
  reviewUrl="inputTag/delimiter"
  height="300px"
/>

## 触发方式

通过 `trigger` 属性设置添加标签的触发方式（如 enter 或 space）。

<CodeView
  codeUrl="inputTag/input_tag_trigger.dart"
  reviewUrl="inputTag/trigger"
  height="300px"
/>

## saveOnBlur

通过 `saveOnBlur` 属性设置失去焦点时是否保存输入。

<CodeView
  codeUrl="inputTag/input_tag_save_on_blur.dart"
  reviewUrl="inputTag/save-on-blur"
  height="300px"
/>

## 可清空

通过 `clearable` 属性控制是否显示清除按钮。

<CodeView
  codeUrl="inputTag/input_tag_clearable.dart"
  reviewUrl="inputTag/clearable"
  height="300px"
/>

## 禁用和只读

通过 `disabled` 和 `readOnly` 属性控制输入框的禁用和只读状态。

<CodeView
  codeUrl="inputTag/input_tag_disabled_readonly.dart"
  reviewUrl="inputTag/disabled-readonly"
  height="300px"
/>

## 不同尺寸

通过 `size` 属性设置输入框尺寸。

<CodeView
  codeUrl="inputTag/input_tag_size.dart"
  reviewUrl="inputTag/size"
  height="300px"
/>

## 自定义样式

通过 `customFontSize`、`customHeight`、`customBorderRadius` 属性自定义样式。

<CodeView
  codeUrl="inputTag/input_tag_custom_style.dart"
  reviewUrl="inputTag/custom-style"
  height="300px"
/>

## 自定义颜色

通过 `customColor`、`defaultColor` 属性自定义颜色。

<CodeView
  codeUrl="inputTag/input_tag_custom_color.dart"
  reviewUrl="inputTag/custom-color"
  height="300px"
/>

## API/事件

展示所有常用事件和回调。

<CodeView
  codeUrl="inputTag/input_tag_api.dart"
  reviewUrl="inputTag/api"
  height="300px"
/>

## API

### InputTag 属性

| 属性名             | 说明               | 类型                                    | 默认值   |
| ------------------ | ------------------ | --------------------------------------- | -------- |
| value              | 标签值             | `List<String>`                          | -        |
| onChanged          | 标签变化时回调     | `(List<String>?) => void`               | -        |
| tagBuilder         | 自定义标签渲染     | `Widget Function(BuildContext, String)` | -        |
| prefix             | 输入框前缀         | `Widget?`                               | -        |
| suffix             | 输入框后缀         | `Widget?`                               | -        |
| max                | 最大标签数量       | `int?`                                  | -        |
| delimiter          | 分隔符             | `String?`                               | -        |
| trigger            | 触发方式           | `EInputTagTrigger`                      | `space`  |
| saveOnBlur         | 失焦时是否保存输入 | `bool`                                  | `true`   |
| clearable          | 是否可清空         | `bool`                                  | `false`  |
| disabled           | 是否禁用           | `bool`                                  | `false`  |
| readOnly           | 是否只读           | `bool`                                  | `false`  |
| size               | 输入框尺寸         | `ESizeItem`                             | `medium` |
| customFontSize     | 自定义字体大小     | `double?`                               | -        |
| customHeight       | 自定义高度         | `double?`                               | -        |
| customBorderRadius | 自定义圆角         | `double?`                               | -        |
| customColor        | 自定义颜色         | `Color?`                                | -        |
| defaultColor       | 默认颜色           | `Color?`                                | -        |

### InputTag 事件

| 事件名      | 说明                 | 参数                               |
| ----------- | -------------------- | ---------------------------------- |
| onChanged   | 标签变化时触发       | `(List<String>?) => void`          |
| onFocus     | 输入框获得焦点时触发 | `() => void`                       |
| onBlur      | 输入框失去焦点时触发 | `() => void`                       |
| onAddTag    | 添加标签时触发       | `(String tag, List<String> value)` |
| onRemoveTag | 移除标签时触发       | `(String tag, List<String> value)` |
| onClear     | 清空标签时触发       | `() => void`                       |

</rewritten_file>
