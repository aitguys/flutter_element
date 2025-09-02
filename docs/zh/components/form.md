# Form 表单

表单组件，用于数据录入、校验，支持多种布局方式。

## 基础用法

表单由 `EForm` 和 `EFormItem` 组成，`EFormItem` 是表单项容器，用于包装各种输入组件。

<CodeView
  codeUrl="form_page/form_basic.dart"
  reviewUrl="form/basic"
  height="300px"
/>



## API

### EForm

| 参数 | 说明 | 类型 | 可选值 | 默认值 |
|------|------|------|--------|--------|
| children | 表单项列表 | `List<Widget>` | — | — |
| controller | 表单控制器 | `EFormController` | — | — |
| labelPosition | 标签位置 | `String` | left / top / right | left |
| labelWidth | 标签宽度 | `dynamic` | double / 'auto' | 'auto' |
| formItemTextStyle | 表单项文字样式 | `TextStyle` | — | TextStyle(fontSize: 14) |
| disabled | 是否禁用 | `bool` | — | false |
| readOnly | 是否只读 | `bool` | — | false |
| size | 尺寸 | `ESizeItem` | small / medium / large | small |


### EFormItem

| 参数 | 说明 | 类型 | 可选值 | 默认值 |
|------|------|------|--------|--------|
| label | 标签文本 | `String` | — | — |
| child | 表单项内容 | `Widget` | — | — |
| textStyle | 标签文字样式 | `TextStyle` | — | — |
| labelPosition | 标签位置 | `String` | left / top / right | — |
| isRequired | 是否必填 | `bool` | — | false |
| labelWidth | 标签宽度 | `dynamic` | double / 'auto' | — |
| validator | 验证函数 | `EFormItemValidator` | — | — |
| labelRightChild | 标签右侧内容 | `Widget` | — | — |

### EFormController

| 方法 | 说明 | 参数 | 返回值 |
|------|------|------|--------|
  | valid | 验证表单 | — | `bool` |
| clearValidate | 清除验证错误 | — | `void` |
| reset | 重置表单 | — | `void` |



## 支持的表单组件

Form 组件支持以下输入组件的自动属性注入：

- `EInput` - 输入框
- `ESelect` - 选择器
- `EInputNumber` - 数字输入框
- `EInputTag` - 标签输入框
- `ERadioGroup` - 单选框组
- `EDatePicker` - 日期选择器

当设置表单的 `disabled`、`readOnly` 或 `size` 属性时，这些属性会自动传递给子组件。

## 注意事项

1. 每个 `EForm` 必须有一个唯一的 `EFormController`
2. 验证函数返回 `null` 表示验证通过，返回字符串表示验证失败的错误信息
3. 标签宽度设置为 `'auto'` 时会自动计算所有标签的最大宽度
4. 表单的 `disabled` 和 `readOnly` 属性会覆盖单个表单项的设置
5. 使用 `labelRightChild` 时，建议使用小尺寸的按钮或图标组件 
