# Select 选择器

用于在多个选项中选择单个或多个值。

## 实现原理

基于 Dropdown、ListView、Text、Icon 等组件实现，支持单选、多选、禁用、可清空、自定义头部、前后缀等功能。

## 基础用法

使用 `value`、`options` 和 `onChanged` 属性实现基本的选择功能。

<CodeView
  codeUrl="select_page/select_basic.dart"
  reviewUrl="select/basic"
  height="300px"
/>

## 单选和多选

通过 `multiple` 属性切换单选和多选，单选时 `value` 为 `String?`，多选时为 `List<String>?`。

<CodeView
  codeUrl="select_page/select_multiple.dart"
  reviewUrl="select/multiple"
  height="300px"
/>

## 禁用状态

使用 `disabled` 属性禁用选择器。

<CodeView
  codeUrl="select_page/select_disable.dart"
  reviewUrl="select/disable"
  height="300px"
/>

## 可清空

使用 `clearable` 属性启用清空功能。

<CodeView
  codeUrl="select_page/select_clearable.dart"
  reviewUrl="select/clearable"
  height="300px"
/>

## 前缀/后缀/插槽

通过 `prefix`、`suffix`、`prepend`、`append` 属性自定义前缀、后缀和插槽内容。

<CodeView
  codeUrl="select_page/select_prefix_suffix.dart"
  reviewUrl="select/prefix-suffix"
  height="300px"
/>

## 有禁用选项

`SelectOption` 支持 `disabled` 字段，可设置部分选项不可选。

<CodeView
  codeUrl="select_page/select_option_disable.dart"
  reviewUrl="select/option-disable"
  height="300px"
/>

## 自定义头部

通过 `header` 属性自定义下拉面板头部内容。

<CodeView
  codeUrl="select_page/select_header.dart"
  reviewUrl="select/header"
  height="300px"
/>

## API 调用

支持 `onChanged`、`onClear` 等事件。

<CodeView
  codeUrl="select_page/select_api.dart"
  reviewUrl="select/api"
  height="300px"
/>

## API

### Select 属性

| 属性名             | 说明                    | 类型                      | 默认值             |
| ------------------ | ----------------------- | ------------------------- | ------------------ |
| value              | 当前选中值（单选/多选） | `String?`/`List<String>?` | -                  |
| options            | 选项列表                | `List<SelectOption>`      | -                  |
| placeholder        | 占位符文本              | `String?`                 | "请选择"           |
| size               | 选择器尺寸              | `ESizeItem`               | `ESizeItem.medium` |
| customHeight       | 自定义高度              | `double?`                 | -                  |
| customFontSize     | 自定义字体大小          | `double?`                 | -                  |
| customBorderRadius | 自定义圆角              | `double?`                 | -                  |
| multiple           | 是否多选                | `bool`                    | `false`            |
| disabled           | 是否禁用                | `bool`                    | `false`            |
| clearable          | 是否可清空              | `bool`                    | `false`            |
| filterable         | 是否可输入搜索          | `bool`                    | `false`            |
| prefix             | 前缀                    | `Widget?`                 | -                  |
| suffix             | 后缀（可替换默认箭头）  | `Widget?`                 | -                  |
| prepend            | 头部插槽                | `Widget?`                 | -                  |
| append             | 尾部插槽                | `Widget?`                 | -                  |
| header             | 自定义下拉面板头部      | `Widget?`                 | -                  |
| onChanged          | 选中值变化时回调        | `Function(dynamic)`       | -                  |
| onClear            | 清空时回调              | `VoidCallback?`           | -                  |

### SelectOption 属性

| 属性名   | 说明     | 类型     | 默认值  |
| -------- | -------- | -------- | ------- |
| value    | 选项值   | `String` | -       |
| label    | 选项文本 | `String` | -       |
| disabled | 是否禁用 | `bool`   | `false` |

### Select 事件

| 事件名    | 说明         | 参数      |
| --------- | ------------ | --------- |
| onChanged | 选中值变化时 | `dynamic` |
| onClear   | 清空时触发   | -         |

</rewritten_file>
