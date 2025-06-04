# InputNumber 数字输入框

仅允许输入标准数字格式的输入框。

## 实现原理

使用 TextField 嵌套 Row、IconButton 等组件实现数字输入、步进控制、范围限制等功能。

## 基础用法

使用 `value` 和 `onChanged` 属性来实现数字输入框的基本功能。

<CodeView
  codeUrl="inputNumber/input_number_basic.dart"
  reviewUrl="inputNumber/basic"
  height="300px"
/>

## 步进幅度和范围限制

使用 `step`、`min`、`max` 属性来控制数字的步进幅度和范围限制。

<CodeView
  codeUrl="inputNumber/input_number_controls.dart"
  reviewUrl="inputNumber/controls"
  height="300px"
/>

## 可清空

使用 `clearable` 属性来启用清空功能。

<CodeView
  codeUrl="inputNumber/input_number_clearable.dart"
  reviewUrl="inputNumber/clearable"
  height="300px"
/>

## 前缀和后缀

使用 `prefix` 和 `suffix` 属性来添加输入框的前缀和后缀。

<CodeView
  codeUrl="inputNumber/input_number_prefix_suffix.dart"
  reviewUrl="inputNumber/prefix-suffix"
  height="300px"
/>

## 自定义图标

使用 `decreaseIcon` 和 `increaseIcon` 属性来自定义增减按钮的图标。

<CodeView
  codeUrl="inputNumber/input_number_custom_icons.dart"
  reviewUrl="inputNumber/custom-icons"
  height="300px"
/>

## 禁用和只读

使用 `disabled` 和 `readOnly` 属性来控制输入框的禁用和只读状态。

<CodeView
  codeUrl="inputNumber/input_number_disabled.dart"
  reviewUrl="inputNumber/disabled"
  height="300px"
/>

## 不同尺寸

使用 `size` 属性来定义输入框的尺寸，支持 small、medium、large 三种尺寸。

<CodeView
  codeUrl="inputNumber/input_number_size.dart"
  reviewUrl="inputNumber/size"
  height="300px"
/>

## 按钮位置

使用 `controlsPosition` 属性来控制增减按钮的位置。

<CodeView
  codeUrl="inputNumber/input_number_position.dart"
  reviewUrl="inputNumber/position"
  height="300px"
/>

## 自定义样式

使用 `colorType`、`customColor`、`customHeight` 等属性来自定义输入框的样式。

<CodeView
  codeUrl="inputNumber/input_number_style.dart"
  reviewUrl="inputNumber/style"
  height="300px"
/>

## API

### InputNumber 属性

| 属性名             | 说明           | 类型                           | 默认值                               |
| ------------------ | -------------- | ------------------------------ | ------------------------------------ |
| value              | 绑定值         | `double?`                      | -                                    |
| onChanged          | 值改变时触发   | `(double?) => void`            | -                                    |
| step               | 步进幅度       | `double`                       | `1`                                  |
| min                | 最小值         | `double?`                      | -                                    |
| max                | 最大值         | `double?`                      | -                                    |
| size               | 输入框尺寸     | `ESizeItem`                    | `ESizeItem.medium`                   |
| disabled           | 是否禁用       | `bool`                         | `false`                              |
| readOnly           | 是否只读       | `bool`                         | `false`                              |
| clearable          | 是否可清空     | `bool`                         | `false`                              |
| prefix             | 输入框前缀     | `Widget?`                      | -                                    |
| suffix             | 输入框后缀     | `Widget?`                      | -                                    |
| decreaseIcon       | 减少按钮图标   | `Widget?`                      | -                                    |
| increaseIcon       | 增加按钮图标   | `Widget?`                      | -                                    |
| controlsPosition   | 控制按钮位置   | `EInputNumberControlsPosition` | `EInputNumberControlsPosition.right` |
| colorType          | 颜色类型       | `EColorType?`                  | -                                    |
| customColor        | 自定义颜色     | `Color?`                       | -                                    |
| customHeight       | 自定义高度     | `double?`                      | -                                    |
| customFontSize     | 自定义字体大小 | `double?`                      | -                                    |
| customBorderRadius | 自定义圆角     | `double?`                      | -                                    |

### InputNumber 事件

| 事件名    | 说明                 | 参数                |
| --------- | -------------------- | ------------------- |
| onChanged | 值改变时触发         | `(double?) => void` |
| onFocus   | 输入框获得焦点时触发 | `() => void`        |
| onBlur    | 输入框失去焦点时触发 | `() => void`        |

</rewritten_file>
