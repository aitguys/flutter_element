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

结合 `ERadioGroup` 和 `ERadio` 组件组合使用实现单选框组。

<CodeView
  codeUrl="radio_page/radio_group.dart"
  reviewUrl="radio/group"
  height="100px"
/>

## 不同尺寸

使用 `size` 属性来定义单选框的尺寸， 也可以通过 `customFontSize` 属性来定义单选框的文字大小。

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

customFontSize 和 fontColorType 等属性可以定义在 ERadioGroup 中，这样所有子元素都会继承这些属性。

| 属性名          | 说明           | 类型         | 默认值               |
| --------------- | -------------- | ------------ | -------------------- |
| value           | 单选框的值     | `String?`    | -                    |
| label           | 单选框的标签   | `String?`    | -                    |
| disabled        | 是否禁用       | `boolean`    | `false`              |
| border          | 是否显示边框   | `boolean`    | `false`              |
| size            | 单选框的尺寸   | `ESizeItem`  | `ESizeItem.medium`   |
| name            | 原生 name 属性 | `String?`    | -                    |
| customFontSize  | 自定义文字大小 | `double?`    | -                    |
| fontColorType   | 文字颜色类型   | `EColorType` | `EColorType.primary` |
| fontCustomColor | 文字颜色       | `Color?`     | -                    |
| iconColorType   | 图标颜色类型   | `EColorType` | `EColorType.primary` |
| iconCustomColor | 图标颜色       | `Color?`     | -                    |

### RadioGroup 属性

| 属性名          | 说明           | 类型                    | 默认值               |
| --------------- | -------------- | ----------------------- | -------------------- |
| value           | 绑定值         | `String?`               | -                    |
| disabled        | 是否禁用       | `boolean`               | `false`              |
| size            | 单选框的尺寸   | `ESizeItem`             | `ESizeItem.medium`   |
| customFontSize  | 自定义文字大小 | `double?`               | -                    |
| fontColorType   | 文字颜色类型   | `EColorType`            | `EColorType.primary` |
| fontCustomColor | 文字颜色       | `Color?`                | -                    |
| iconColorType   | 图标颜色类型   | `EColorType`            | `EColorType.primary` |
| iconCustomColor | 图标颜色       | `Color?`                | -                    |
| children        | 子组件列表     | `List<Widget>`          | -                    |
| onChanged       | 值变化时触发   | `ValueChanged<String>?` | -                    |

### RadioGroup 事件

| 事件名    | 说明             | 参数                     |
| --------- | ---------------- | ------------------------ |
| onChanged | 选中值变化时触发 | `(String value) => void` |
