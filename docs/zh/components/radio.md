# Radio 单选框

在一组备选项中进行单选。

## 实现原理

使用 MouseRegion 嵌套 GestureDetector、Container、Text 等组件实现单选功能，通过 InheritedWidget 实现 RadioGroup 的状态共享。

## 基础用法

使用 `value` 和 `label` 属性来定义单选框的值和标签。

<CodeView
  codeUrl="radio_page/radio_basic.dart"
  reviewUrl="radio/basic"
  height="100px"
/>

## 禁用状态

使用 `disabled` 属性来控制单选框是否为禁用状态。

<CodeView
  codeUrl="radio_page/radio_disable.dart"
  reviewUrl="radio/disable"
  height="200px"
/>

## 单选框组

适用于在多个互斥的选项中选择的场景。结合 `ERadioGroup` 和 `ERadio` 组件实现单选组。

<CodeView
  codeUrl="radio_page/radio_group.dart"
  reviewUrl="radio/group"
  height="100px"
/>

## 不同尺寸

使用 `size` 属性来定义单选框的尺寸。

<CodeView
  codeUrl="radio_page/radio_size.dart"
  reviewUrl="radio/size"
  height="300px"
/>

## 带边框

设置 `border` 属性为 true 可以渲染为带有边框的单选框。

<CodeView
  codeUrl="radio_page/radio_border.dart"
  reviewUrl="radio/border"
  height="100px"
/>

## API

### Radio 属性

| 属性名    | 说明           | 类型                | 默认值                |
| --------- | -------------- | ------------------- | --------------------- |
| value     | 单选框的值      | `String?`          | -                     |
| label     | 单选框的标签    | `String?`          | -                     |
| disabled  | 是否禁用       | `boolean`          | `false`              |
| border    | 是否显示边框    | `boolean`          | `false`              |
| size      | 单选框的尺寸    | `ERadioSize`       | `ERadioSize.medium`  |
| name      | 原生 name 属性 | `String?`          | -                     |
| onChanged | 值变化时触发    | `ValueChanged<String>?` | -                |

### RadioGroup 属性

| 属性名    | 说明           | 类型                | 默认值                |
| --------- | -------------- | ------------------- | --------------------- |
| value     | 绑定值         | `String?`          | -                     |
| disabled  | 是否禁用       | `boolean`          | `false`              |
| size      | 单选框的尺寸    | `ERadioSize`       | `ERadioSize.medium`  |
| onChanged | 值变化时触发    | `ValueChanged<String>?` | -                |
| children  | 子组件列表      | `List<Widget>`     | -                     |

### Radio 事件

| 事件名     | 说明           | 参数                     |
| ---------- | -------------- | ------------------------ |
| onChanged  | 选中值变化时触发 | `(String value) => void` |

### RadioGroup 事件

| 事件名     | 说明           | 参数                     |
| ---------- | -------------- | ------------------------ |
| onChanged  | 选中值变化时触发 | `(String value) => void` | 