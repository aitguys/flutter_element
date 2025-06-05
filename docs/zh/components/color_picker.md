# ColorPicker 颜色选择器

用于选择和自定义颜色，支持透明度、预设色、不同尺寸等多种功能。

## 实现原理

基于 Overlay、ColorPicker、CupertinoTextField 等组件实现弹出式颜色选择，支持颜色预设、透明度调节、HEX 输入等。

## 基础用法

通过 `pickerColor` 设置当前颜色，`onColorChanged` 监听颜色变化。

<CodeView
  codeUrl="color_picker_page/color_picker_basic.dart"
  reviewUrl="color_picker/basic"
  height="300px"
/>

## 带 Alpha 通道

设置 `showAlpha` 属性可支持透明度调节。

<CodeView
  codeUrl="color_picker_page/color_picker_alpha.dart"
  reviewUrl="color_picker/alpha"
  height="300px"
/>

## 预设颜色

通过 `predefine` 属性设置常用颜色，便于快速选择。

<CodeView
  codeUrl="color_picker_page/color_picker_predefine.dart"
  reviewUrl="color_picker/predefine"
  height="300px"
/>

## 不同尺寸

通过 `size` 或 `customSize` 属性设置颜色选择器的尺寸。

<CodeView
  codeUrl="color_picker_page/color_picker_size.dart"
  reviewUrl="color_picker/size"
  height="300px"
/>

## 禁用状态

设置 `disabled` 属性可禁用颜色选择器。

<CodeView
  codeUrl="color_picker_page/color_picker_disabled.dart"
  reviewUrl="color_picker/disabled"
  height="300px"
/>

## API

### ColorPicker 属性

| 属性名       | 说明                       | 类型            | 默认值                |
| ------------ | -------------------------- | --------------- | --------------------- |
| pickerColor  | 当前颜色                   | `Color`         | `Colors.red`          |
| onColorChanged | 颜色变化回调              | `ValueChanged<Color>` | -               |
| showAlpha    | 是否显示透明度调节         | `bool`          | `false`               |
| predefine    | 预设颜色列表               | `List<Color>?`   | `null`                |
| disabled     | 是否禁用                   | `bool`          | `false`               |
| size         | 选择器尺寸                 | `ESizeItem`      | `ESizeItem.medium`    |
| customSize   | 自定义尺寸                 | `double?`        | `null`                |
| width        | 弹窗宽度                   | `double?`        | `null`                |
| onConfirm    | 确认选择回调               | `Function(Color)?` | `null`              |
| onCancel     | 取消选择回调               | `Function()?`    | `null`                |

### ColorPicker 事件

| 事件名         | 说明           | 参数         |
| -------------- | -------------- | ------------ |
| onColorChanged | 颜色变化时触发 | `Color`      |
| onConfirm      | 点击确认时触发 | `Color`      |
| onCancel       | 点击取消时触发 | -            |

</rewritten_file> 