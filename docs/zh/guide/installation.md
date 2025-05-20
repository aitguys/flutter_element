# 安装

## 环境要求

- Flutter SDK: 2.0.0 或更高版本
- Dart SDK: 2.12.0 或更高版本

## 使用 pub 安装

1. 在项目的 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flutter_element: ^1.0.0
```

2. 运行以下命令安装：

```bash
flutter pub get
```

## 手动安装

1. 克隆仓库到本地：

```bash
git clone https://github.com/your-repo/flutter-element.git
```

2. 在项目的 `pubspec.yaml` 文件中添加本地依赖：

```yaml
dependencies:
  flutter_element:
    path: ../flutter-element
```

3. 运行以下命令安装：

```bash
flutter pub get
```

## 验证安装

在你的代码中导入并使用：

```dart
import 'package:flutter_element/flutter_element.dart';

// 使用按钮组件
ElButton(
  type: ElButtonType.primary,
  child: Text('Primary Button'),
  onPressed: () {
    print('Button pressed!');
  },
)
```

## 下一步

- [快速开始](/guide/getting-started) - 了解如何使用 Flutter Element
- [组件](/components/) - 浏览所有可用组件
