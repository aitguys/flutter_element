# Image 图片

图片容器，在保留所有原生图片属性的同时，支持懒加载，自定义占位、加载失败占位等功能。

## 基础用法

基础图片展示，可设置宽度、高度等属性。

<CodeView
  codeUrl="image_page/image_basic.dart"
  reviewUrl="image/basic"
  height="200px"
/>

## 填充方式

使用 `fit` 属性来定义图片的填充方式。

<CodeView
  codeUrl="image_page/image_fit.dart"
  reviewUrl="image/fit"
  height="300px"
/>

## 占位图

使用 `placeholder` 属性来设置图片加载时的占位内容。

<CodeView
  codeUrl="image_page/image_placeholder.dart"
  reviewUrl="image/placeholder"
  height="200px"
/>

## 图片预览

使用 `preview` 属性来启用图片预览功能。预览模式下支持：
- 点击放大
- 缩放
- 旋转
- 全屏查看

<CodeView
  codeUrl="image_page/image_preview.dart"
  reviewUrl="image/preview"
  height="200px"
/>

## 圆角图片

使用 `borderRadius` 属性来设置图片的圆角。

<CodeView
  codeUrl="image_page/image_radius.dart"
  reviewUrl="image/radius"
  height="200px"
/>

## API

### Image 属性

| 属性名      | 说明                     | 类型      | 默认值        |
| ----------- | ------------------------ | --------- | ------------- |
| src         | 图片源地址               | `String`  | -             |
| width       | 图片宽度                 | `double?` | -             |
| height      | 图片高度                 | `double?` | -             |
| fit         | 图片填充方式             | `BoxFit`  | `BoxFit.cover`|
| borderRadius| 图片圆角                 | `double`  | `0`           |
| placeholder | 图片加载时的占位内容     | `Widget?` | -             |
| errorWidget | 图片加载失败时的占位内容 | `Widget?` | -             |
| preview     | 是否开启图片预览功能     | `bool`    | `false`       |