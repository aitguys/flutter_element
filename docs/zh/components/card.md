# Card 卡片

将信息分组展示的容器组件。

## 实现原理

使用 Container 嵌套 Column 实现卡片布局，通过 MouseRegion 实现悬浮效果。

## 基础用法

基础的卡片容器，可以包含标题、内容和底部区域。

<CodeView
  codeUrl="card_page/card_basic.dart"
  reviewUrl="card/basic"
  height="300px"
/>

## 简单卡片

只包含内容区域的简单卡片。

<CodeView
  codeUrl="card_page/card_simple.dart"
  reviewUrl="card/simple"
  height="300px"
/>

## 图片卡片

包含图片的卡片展示。

<CodeView
  codeUrl="card_page/card_image.dart"
  reviewUrl="card/image"
  height="300px"
/>

## 阴影效果

通过 `shadow` 属性设置卡片的阴影效果。

<CodeView
  codeUrl="card_page/card_shadow.dart"
  reviewUrl="card/shadow"
  height="300px"
/>

## API

### Card 属性

| 属性名      | 说明                 | 类型            | 默认值                |
| ----------- | -------------------- | --------------- | --------------------- |
| header      | 卡片标题             | `Widget`        | -                     |
| footer      | 卡片底部             | `Widget`        | -                     |
| child       | 卡片内容             | `Widget`        | -                     |
| bodyStyle   | 自定义卡片内容样式   | `BoxDecoration` | -                     |
| headerClass | 自定义标题 CSS 类名  | `String`        | -                     |
| bodyClass   | 自定义内容 CSS 类名  | `String`        | -                     |
| footerClass | 自定义底部 CSS 类名  | `String`        | -                     |
| shadow      | 卡片阴影效果         | `ECardShadow`   | `ECardShadow.always` |
| margin      | 卡片外边距           | `EdgeInsets`    | -                     |
| padding     | 卡片内边距           | `EdgeInsets`    | `EdgeInsets.all(16)` |
| width       | 卡片宽度             | `double`        | -                     |
| height      | 卡片高度             | `double`        | -                     |

### Card 阴影类型

| 类型    | 说明                 |
| ------- | -------------------- |
| always  | 始终显示阴影         |
| hover   | 鼠标悬浮时显示阴影   |
| never   | 从不显示阴影         |
</rewritten_file> 