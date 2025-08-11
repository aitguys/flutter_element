# 表单组件使用说明

## 概述

表单组件是 Flutter Element Plus 的核心组件之一，提供了完整的表单验证、布局和交互功能。

## 主要特性

- ✅ 支持多种标签位置（左对齐、右对齐、顶部对齐）
- ✅ 支持必填字段验证
- ✅ 支持自定义验证器
- ✅ 支持表单重置和清除验证
- ✅ 支持自动标签宽度计算
- ✅ 支持响应式布局

## 基本用法

### 1. 创建表单

```dart
final formController = EFormController();

EForm(
  controller: formController,
  labelPosition: EFormLabelPosition.left,
  children: [
    // 表单字段...
  ],
)
```

### 2. 添加表单字段

```dart
EFormItem(
  label: '用户名',
  isRequired: true,
  validator: () {
    // 自定义验证逻辑
    return null; // 返回 null 表示验证通过
  },
  child: EInput(
    placeholder: '请输入用户名',
    size: ESizeItem.small,
  ),
)
```

### 3. 表单验证

```dart
// 验证整个表单
if (formController.valid()) {
  print('表单验证通过');
} else {
  print('表单验证失败');
}

// 重置表单
formController.reset();

// 清除验证错误
formController.clearValidate();
```

## 标签位置

### 左对齐（默认）

```dart
EForm(
  labelPosition: EFormLabelPosition.left,
  // ...
)
```

### 右对齐

```dart
EForm(
  labelPosition: EFormLabelPosition.right,
  // ...
)
```

### 顶部对齐

```dart
EForm(
  labelPosition: EFormLabelPosition.top,
  // ...
)
```

## 验证规则

### 必填验证

```dart
EFormItem(
  label: '用户名',
  isRequired: true, // 设置为必填
  child: EInput(placeholder: '请输入用户名'),
)
```

### 自定义验证器

```dart
EFormItem(
  label: '邮箱',
  isRequired: true,
  validator: () {
    final email = 'user@example.com'; // 获取输入值
    if (email.isEmpty) {
      return '邮箱不能为空';
    }
    // 邮箱格式验证
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return '请输入正确的邮箱格式';
    }
    return null; // 验证通过
  },
  child: EInput(placeholder: '请输入邮箱'),
)
```

## 支持的输入组件

- `EInput` - 文本输入框
- `EInputNumber` - 数字输入框
- `ESelect` - 选择器
- `ECheckbox` - 复选框
- `ERadio` - 单选框
- `ETextarea` - 多行文本输入框

## 完整示例

```dart
class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formController = EFormController();

    return EForm(
      controller: formController,
      labelPosition: EFormLabelPosition.left,
      children: [
        EFormItem(
          label: '用户名',
          isRequired: true,
          child: EInput(placeholder: '请输入用户名'),
        ),
        EFormItem(
          label: '邮箱',
          isRequired: true,
          validator: () {
            // 自定义验证逻辑
            return null;
          },
          child: EInput(placeholder: '请输入邮箱'),
        ),
        EButton(
          text: '提交',
          onPressed: () {
            if (formController.valid()) {
              print('提交成功');
            }
          },
        ),
      ],
    );
  }
}
```

## 注意事项

1. 每个表单必须使用唯一的 `EFormController`
2. 必填字段会自动显示红色星号
3. 验证失败时会显示错误信息
4. 表单重置会清除所有输入值和验证状态
5. 清除验证只会清除错误提示，不会清除输入值

## API 参考

### EForm

| 参数          | 类型            | 默认值 | 说明         |
| ------------- | --------------- | ------ | ------------ |
| controller    | EFormController | 必填   | 表单控制器   |
| children      | List<Widget>    | 必填   | 表单字段列表 |
| labelPosition | String          | 'left' | 标签位置     |
| labelWidth    | dynamic         | 'auto' | 标签宽度     |

### EFormItem

| 参数          | 类型     | 默认值 | 说明                     |
| ------------- | -------- | ------ | ------------------------ |
| label         | String   | 必填   | 字段标签                 |
| child         | Widget   | 必填   | 输入组件                 |
| isRequired    | bool     | false  | 是否必填                 |
| validator     | Function | null   | 自定义验证器             |
| labelPosition | String   | null   | 标签位置（覆盖表单设置） |
| labelWidth    | dynamic  | null   | 标签宽度（覆盖表单设置） |

### EFormController

| 方法            | 参数 | 返回值 | 说明         |
| --------------- | ---- | ------ | ------------ |
| valid()         | 无   | bool   | 验证整个表单 |
| reset()         | 无   | void   | 重置表单     |
| clearValidate() | 无   | void   | 清除验证错误 |
