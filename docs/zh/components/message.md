# Message 消息提示

常用于主动操作后的反馈提示。

## 实现原理

使用 Overlay 和 AnimationController 实现消息提示的显示和动画效果。

## 基础用法

使用 `EMessageController` 来调用不同类型的消息提示。

<CodeView
  codeUrl="message_page/message_basic.dart"
  reviewUrl="message/basic"
  height="300px"
/>

## 圆角消息

使用 `isRound` 属性来定义消息提示的圆角样式。

<CodeView
  codeUrl="message_page/message_round.dart"
  reviewUrl="message/round"
  height="300px"
/>

## 消息尺寸

使用 `size` 属性来定义消息提示的尺寸，也可以通过 `padding` 和 `fontSize` 来自定义大小。

<CodeView
  codeUrl="message_page/message_size.dart"
  reviewUrl="message/size"
  height="300px"
/>

## 显示时长

使用 `duration` 属性来控制消息提示的显示时长。

<CodeView
  codeUrl="message_page/message_duration.dart"
  reviewUrl="message/duration"
  height="300px"
/>

## 自定义图标

使用 `icon` 属性来自定义消息提示的图标。

<CodeView
  codeUrl="message_page/message_icon.dart"
  reviewUrl="message/icon"
  height="300px"
/>

## 可关闭的消息

使用 `showClose` 属性来控制是否显示关闭按钮。

<CodeView
  codeUrl="message_page/message_showClose.dart"
  reviewUrl="message/showClose"
  height="300px"
/>

## API 调用

<CodeView
  codeUrl="message_page/message_api.dart"
  reviewUrl="message/api"
  height="300px"
/>

## API

### Message 属性

| 属性名    | 说明                                 | 类型               | 默认值                   |
| --------- | ------------------------------------ | ------------------ | ------------------------ |
| message   | 消息文字                             | `String`           | -                        |
| type      | 消息类型                             | `ElementColorType` | `ElementColorType.info`  |
| size      | 消息尺寸                             | `ElementSizeItem`  | `ElementSizeItem.medium` |
| fontSize  | 自定义消息文字大小                   | `double`           | -                        |
| padding   | 自定义内边距                         | `EdgeInsets`       | -                        |
| icon      | 自定义图标                           | `Widget`           | -                        |
| isRound   | 是否为圆角消息                       | `boolean`          | `false`                  |
| showClose | 是否显示关闭按钮                     | `boolean`          | `false`                  |
| duration  | 显示时长，单位毫秒，0 表示不自动关闭 | `int`              | `3000`                   |

### Message 事件

| 事件名  | 说明           | 参数         |
| ------- | -------------- | ------------ |
| onClose | 消息关闭时触发 | `() => void` |

### MessageController 方法

| 方法名  | 说明         | 参数                               |
| ------- | ------------ | ---------------------------------- |
| success | 显示成功消息 | `(context, message, {...options})` |
| warning | 显示警告消息 | `(context, message, {...options})` |
| info    | 显示信息消息 | `(context, message, {...options})` |
| error   | 显示错误消息 | `(context, message, {...options})` |
