# Checkbox 多选框

常用的多选框组件。

## 实现原理

基于 MouseRegion、GestureDetector、Container、Icon、Text 等组件实现交互和样式，支持单选、多选、禁用、自定义颜色、尺寸、全选等多种用法。

## 基础用法

通过 `label` 属性设置文本，`onChange` 监听选中状态变化。

<CodeView
  codeUrl="checkbox_page/checkbox_basic.dart"
  reviewUrl="checkbox/basic"
  height="120px"
/>

## 自定义样式

通过 `fontColorType`、`iconColorType`、`fontCustomColor`、`iconCustomColor` 属性自定义文字和图标颜色。

<CodeView
  codeUrl="checkbox_page/checkbox_theme.dart"
  reviewUrl="checkbox/theme"
  height="120px"
/>

## 尺寸/字体

通过 `size` 属性设置多选框尺寸，通过 `customFontSize` 自定义字体大小。

<CodeView
  codeUrl="checkbox_page/checkbox_size.dart"
  reviewUrl="checkbox/size"
  height="120px"
/>

## 禁用状态

通过 `disabled` 属性设置禁用状态。

<CodeView
  codeUrl="checkbox_page/checkbox_disable.dart"
  reviewUrl="checkbox/disable"
  height="120px"
/>

## 组合/组

通过 `ECheckboxGroup` 组件实现多选组，`value` 绑定选中项，`onChange` 监听变化。

<CodeView
  codeUrl="checkbox_page/checkbox_group.dart"
  reviewUrl="checkbox/group"
  height="120px"
/>

## 边框

通过 `border` 属性显示边框样式。

<CodeView
  codeUrl="checkbox_page/checkbox_border.dart"
  reviewUrl="checkbox/border"
  height="120px"
/>

## 全选

通过控制 `value` 实现全选/反选。

<CodeView
  codeUrl="checkbox_page/checkbox_select_all.dart"
  reviewUrl="checkbox/select-all"
  height="180px"
/>

## API

### Checkbox 属性

| 属性名          | 说明           | 类型         | 默认值    |
| --------------- | -------------- | ------------ | --------- |
| label           | 选项文本       | `String?`    | -         |
| value           | 当前选中状态   | `bool?`      | -         |
| checked         | 初始选中状态   | `bool`       | `false`   |
| disabled        | 是否禁用       | `bool`       | `false`   |
| border          | 是否显示边框   | `bool`       | `false`   |
| size            | 尺寸           | `ESizeItem`  | `medium`  |
| fontColorType   | 文字颜色类型   | `EColorType` | `primary` |
| fontCustomColor | 自定义文字颜色 | `Color?`     | -         |
| iconColorType   | 图标颜色类型   | `EColorType` | `primary` |
| iconCustomColor | 自定义图标颜色 | `Color?`     | -         |
| customFontSize  | 自定义字体大小 | `double?`    | -         |

### Checkbox 事件

| 事件名   | 说明           | 参数         |
| -------- | -------------- | ------------ |
| onChange | 状态变化时触发 | `bool value` |

### CheckboxGroup 属性

| 属性名   | 说明     | 类型           | 默认值   |
| -------- | -------- | -------------- | -------- |
| value    | 选中项   | `List<String>` | -        |
| size     | 尺寸     | `ESizeItem`    | `medium` |
| disabled | 是否禁用 | `bool`         | `false`  |
| children | 子组件   | `List<Widget>` | `[]`     |

### CheckboxGroup 事件

| 事件名   | 说明             | 参数           |
| -------- | ---------------- | -------------- |
| onChange | 选中项变化时触发 | `List<String>` |
