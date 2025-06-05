# Rate 评分

用于对事物进行快速评分的组件。

## 实现原理

使用 MouseRegion 嵌套 GestureDetector、Container、Icon、Text 等组件实现评分交互和样式。

## 基础用法

通过设置 `value` 和 `onChanged` 属性来实现评分的基本交互。

<CodeView
  codeUrl="rate_page/rate_basic.dart"
  reviewUrl="rate/basic"
  height="300px"
/>

## 允许半选

设置 `allowHalf` 属性可以支持半星评分。

<CodeView
  codeUrl="rate_page/rate_half.dart"
  reviewUrl="rate/half"
  height="300px"
/>

## 显示文字

设置 `showText` 并传入 `texts` 属性，可以为每个评分值显示对应的文字描述。

<CodeView
  codeUrl="rate_page/rate_text.dart"
  reviewUrl="rate/text"
  height="300px"
/>

## 显示分数

设置 `showScore` 属性可以显示当前分数，`scoreTemplate` 可自定义分数字符串格式。

<CodeView
  codeUrl="rate_page/rate_score.dart"
  reviewUrl="rate/score"
  height="300px"
/>

## 自定义颜色

通过 `colors` 属性自定义不同分值区间的颜色，或通过 `colorType` 设置主题色。

<CodeView
  codeUrl="rate_page/rate_colors.dart"
  reviewUrl="rate/colors"
  height="300px"
/>

## 不同尺寸

通过 `size` 属性设置不同尺寸，或通过 `customSize`、`customFontSize` 自定义 icon 和文字大小。

<CodeView
  codeUrl="rate_page/rate_size.dart"
  reviewUrl="rate/size"
  height="300px"
/>

## API

### Rate 属性

| 属性名         | 说明                                 | 类型                   | 默认值  |
| -------------- | ------------------------------------ | ---------------------- | ------- |
| value          | 当前分值                             | `double`               | 0       |
| max            | 最大分值                             | `double`               | 5       |
| disabled       | 是否禁用                             | `bool`                 | false   |
| allowHalf      | 是否允许半选                         | `bool`                 | false   |
| showText       | 是否显示文字描述                     | `bool`                 | false   |
| showScore      | 是否显示分数                         | `bool`                 | false   |
| clearable      | 是否可清空评分                       | `bool`                 | false   |
| size           | 评分组件尺寸（large/medium/small）   | `ESizeItem`            | medium  |
| customSize     | 自定义 icon 尺寸                     | `double?`              | -       |
| customFontSize | 自定义文字尺寸                       | `double?`              | -       |
| colorType      | 主题色类型                           | `EColorType`           | primary |
| texts          | 文字描述数组（需与 max 保持一致）    | `List<String>?`        | -       |
| scoreTemplate  | 分数字符串模板，{value} 占位当前分数 | `String?`              | -       |
| colors         | 分值区间颜色数组（1/3/自定义）       | `List<Color>?`         | -       |
| onChanged      | 分值变化回调                         | `ValueChanged<double>` | -       |
