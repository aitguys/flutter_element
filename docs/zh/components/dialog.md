# Dialog 对话框

在保留当前页面状态的情况下，告知用户并承载相关操作。

## 实现原理

使用 `showDialog` 和自定义 `Dialog` 组件实现，支持函数式调用和组件式调用两种方式。

## 基础用法

使用 `showEDialog` 函数来打开对话框。

<CodeView
  codeUrl="dialog_page/dialog_basic.dart"
  reviewUrl="dialog/basic"
  height="300px"
/>

## 自定义内容

通过 `content` 属性可以自定义对话框的内容。

<CodeView
  codeUrl="dialog_page/dialog_custom_content.dart"
  reviewUrl="dialog/custom-content"
  height="300px"
/>

## 组件式调用

通过 `EDialog` 组件和 `visible` 属性来控制对话框的显示和隐藏。

<CodeView
  codeUrl="dialog_page/dialog_component.dart"
  reviewUrl="dialog/component"
  height="300px"
/>

## 可拖拽对话框

使用 `draggable` 属性来启用对话框的拖拽功能。

<CodeView
  codeUrl="dialog_page/dialog_draggable.dart"
  reviewUrl="dialog/draggable"
  height="300px"
/>

## API

### Dialog 属性

| 属性名    | 说明                 | 类型      | 默认值  |
| --------- | -------------------- | --------- | ------- |
| visible   | 是否显示对话框       | `boolean` | `false` |
| title     | 对话框标题           | `String`  | -       |
| content   | 对话框内容           | `Widget`  | -       |
| draggable | 是否可拖拽           | `boolean` | `false` |
| actions   | 对话框底部按钮       | `List<Widget>` | - |
| onClose   | 关闭对话框的回调函数 | `() => void` | - |

### Dialog 方法

| 方法名       | 说明                 | 参数 |
| ------------ | -------------------- | ---- |
| showEDialog  | 打开对话框的函数     | `BuildContext context, {required String title, required Widget content, List<Widget>? actions, bool draggable = false}` | 