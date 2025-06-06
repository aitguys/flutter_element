# Tag 标签

用于标记和分类的标签组件。

## 实现原理

使用 Container、Text、Icon 等组件实现标签的样式和交互效果。

## 基础用法

使用 `type` 属性来定义标签的类型。

<CodeView
  codeUrl="tag_page/tag_basic.dart"
  reviewUrl="tag/basic"
  height="200px"
/>

## 可移除标签

使用 `closable` 属性来定义标签是否可移除。使用 `onClose` 属性来处理标签移除事件。

<CodeView
  codeUrl="tag_page/tag_removable.dart"
  reviewUrl="tag/removable"
  height="200px"
/>

## 不同尺寸

使用 `size` 属性来定义标签的尺寸。

<CodeView
  codeUrl="tag_page/tag_size.dart"
  reviewUrl="tag/size"
  height="200px"
/>

## 自定义颜色

使用 `color` 属性来自定义标签的颜色。

<CodeView
  codeUrl="tag_page/tag_custom_color.dart"
  reviewUrl="tag/custom-color"
  height="200px"
/>

## 自定义内容

使用 `child` 属性来自定义标签的内容。

<CodeView
  codeUrl="tag_page/tag_custom_content.dart"
  reviewUrl="tag/custom-content"
  height="200px"
/>

## 带图标的标签

使用 `icon` 属性来为标签添加图标。

<CodeView
  codeUrl="tag_page/tag_icon.dart"
  reviewUrl="tag/icon"
  height="200px"
/>

## API

### Tag 属性

| 属性名     | 说明           | 类型         | 默认值                |
| ---------- | -------------- | ------------ | --------------------- |
| text       | 标签文字       | `String`     | -                     |
| type       | 标签类型       | `EColorType` | `EColorType.default_` |
| size       | 标签尺寸       | `ESizeItem`  | `ESizeItem.medium`    |
| color      | 自定义标签颜色 | `Color`      | -                     |
| closable   | 是否可关闭     | `boolean`    | `false`               |
| icon       | 图标           | `IconData`   | -                     |
| child      | 自定义标签内容 | `Widget`     | -                     |
| isDisabled | 是否禁用       | `boolean`    | `false`               |
| isPlain    | 是否为朴素标签 | `boolean`    | `false`               |
| isRound    | 是否为圆角标签 | `boolean`    | `false`               |

### Tag 事件

| 事件名  | 说明       | 参数         |
| ------- | ---------- | ------------ |
| onClose | 关闭时触发 | `() => void` |
| onClick | 点击时触发 | `() => void` |

</rewritten_file>
