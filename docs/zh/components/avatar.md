# Avatar 头像

用图标、图片或者字符的形式展示用户或事物信息。

## 基础用法

通过 `shape` 属性来设置头像的形状。

<CodeView
  codeUrl="avatar_page/avatar_basic.dart"
  reviewUrl="avatar/basic"
  height="200px"
/>

## 不同尺寸

通过 `avatarSize` 属性来设置头像的尺寸，也可以通过 `customSize` 属性来设置自定义尺寸。

<CodeView
  codeUrl="avatar_page/avatar_size.dart"
  reviewUrl="avatar/size"
  height="200px"
/>

## 适应容器

通过 `fit` 属性来设置图片如何适应容器框，同原生 `Image` 组件的 `BoxFit` 属性。

<CodeView
  codeUrl="avatar_page/avatar_fit.dart"
  reviewUrl="avatar/fit"
  height="200px"
/>

## 加载失败回退

当展示类型为图片的时候，图片加载失败的展示方式。

<CodeView
  codeUrl="avatar_page/avatar_fallback.dart"
  reviewUrl="avatar/fallback"
  height="200px"
/>

## API

### Avatar 属性

| 属性名      | 说明                     | 类型                | 默认值                |
| ----------- | ------------------------ | ------------------- | --------------------- |
| src         | 图片头像的资源地址       | `String?`           | -                     |
| icon        | 设置头像的图标           | `IconData?`         | -                     |
| text        | 设置头像的文字           | `String?`           | -                     |
| shape       | 设置头像的形状           | `EAvatarShape`      | `EAvatarShape.circle` |
| avatarSize  | 设置头像的尺寸           | `ESizeItem`         | `ESizeItem.medium`    |
| customSize  | 自定义头像尺寸           | `double?`           | -                     |
| fit         | 当展示类型为图片时，设置图片如何适应容器框 | `BoxFit` | `BoxFit.cover` |
| fallback    | 当图片加载失败时，自定义的展示内容 | `Widget?` | -           |
</rewritten_file> 