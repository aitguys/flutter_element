 # Alert 警告

用于页面中展示重要的提示信息。

## 实现原理

使用 Container、Icon、Text 等组件实现警告提示的样式和布局，通过 Stack 实现关闭按钮的定位。

## 基础用法

使用 `type` 属性来定义 Alert 的样式。

<CodeView
  codeUrl="alert_page/alert_basic.dart"
  reviewUrl="alert/basic"
  height="300px"
/>

## 主题切换

Alert 组件提供了两个不同的主题：light 和 dark。通过设置 `theme` 属性来改变主题，默认为 dark。

<CodeView
  codeUrl="alert_page/alert_theme.dart"
  reviewUrl="alert/theme"
  height="350px"
/>

## 自定义关闭组件

使用 `closable` 属性控制是否显示关闭按钮，使用 `closeButton` 属性自定义关闭按钮的内容。
使用 `showIcon` 属性控制是否显示图标。

<CodeView
  codeUrl="alert_page/alert_close.dart"
  reviewUrl="alert/close"
  height="300px"
/>

## 辅助性文字介绍

使用 `description` 属性来添加辅助性文字介绍。

<CodeView
  codeUrl="alert_page/alert_description.dart"
  reviewUrl="alert/description"
  height="200px"
/>

## 居中对齐

使用 `center` 属性来设置内容居中对齐。

<CodeView
  codeUrl="alert_page/alert_center.dart"
  reviewUrl="alert/center"
  height="200px"
/>

## 函数调用方式

使用 `showAlert` 函数来调用 Alert 组件，支持自动关闭。

<CodeView
  codeUrl="alert_page/alert_api.dart"
  reviewUrl="alert/api"
  height="100px"
/>

## API

### Alert 属性

| 属性名        | 说明                 | 类型          | 默认值                |
| ------------- | -------------------- | ------------- | --------------------- |
| title         | 标题                 | `String`      | -                     |
| description   | 辅助性文字介绍       | `String`      | -                     |
| type          | 类型                 | `EColorType`  | `EColorType.info`     |
| theme         | 主题                 | `EThemeType`  | `EThemeType.dark`     |
| closable      | 是否可关闭           | `boolean`     | `true`                |
| showIcon      | 是否显示图标         | `boolean`     | `true`                |
| center        | 是否居中             | `boolean`     | `false`               |
| customColor   | 自定义颜色           | `Color`       | -                     |
| closeButton   | 自定义关闭按钮       | `Widget`      | -                     |
| onClose       | 关闭时触发的回调函数 | `() => void`  | -                     |

### Alert 函数式调用

| 函数名      | 说明                 | 额外参数                                                                 |
| ----------- | -------------------- | -------------------------------------------------------------------- |
| showAlert   | 显示 Alert 提示      | `context`: BuildContext<br> `autoCloseDuration`: Duration? |

函数式调用需指定 `context` 参数，用于指定显示 Alert 的上下文。
额外支持 `autoCloseDuration` 属性，用于设置自动关闭时间。