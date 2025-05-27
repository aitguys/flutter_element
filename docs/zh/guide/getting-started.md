
# 快速开始

## 介绍

Flutter Element 是一个基于 Material Design 设计规范的 Flutter 组件库，旨在提供美观、易用且高度可定制的 UI 组件，帮助开发者快速构建跨平台应用。

## 特性

- 🎨 **Material Design** - 遵循 Google Material Design 设计规范
- 📱 **跨平台支持** - 支持 iOS、Android、Web 等多个平台
- 🛠️ **可定制主题** - 灵活的主题配置系统
- 💡 **TypeScript 支持** - 完整的类型定义
- 📦 **开箱即用** - 丰富的预置组件
- 🔧 **可扩展** - 易于扩展的组件系统

## 安装

1. 在你的 Flutter 项目的 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  flutter_element: ^1.0.0
```

2. 运行以下命令安装依赖：

```bash
flutter pub get
```

3. 在你的代码中导入：

```dart
import 'package:flutter_element_plus/flutter_element_plus.dart';
```

## 基础用法

这里是一个简单的示例，展示如何使用 Flutter Element 的按钮组件：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Element Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElButton(
                type: ElButtonType.primary,
                child: Text('Primary Button'),
                onPressed: () {
                  print('Button pressed!');
                },
              ),
              SizedBox(height: 16),
              ElButton(
                type: ElButtonType.success,
                child: Text('Success Button'),
                onPressed: () {
                  print('Success!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

# button

// 引入 iframe http://localhost:61703/#/button/basic
<CodeView reviewUrl="http://localhost:61703/#/button/basic" codeUrl="https://raw.githubusercontent.com/chenxu2656/flutter_element/main/example/lib/pages/alert_page/alert_page.dart" :hight='100'/>

## 主题定制å

Flutter Element 提供了灵活的主题定制能力：

```dart
import 'package:flutter_element_plus/flutter_element_plus.dart';

void main() {
  runApp(
    ElApp(
      theme: ElTheme(
        primary: Colors.blue,
        success: Colors.green,
        warning: Colors.orange,
        danger: Colors.red,
        info: Colors.grey,
      ),
      child: MyApp(),
    ),
  );
}
```

## 下一步

- 查看 [组件文档](/components/) 了解更多组件的使用方法
- 阅读 [主题定制](/guide/theme) 学习如何自定义主题
- 访问 [GitHub 仓库](https://github.com/your-repo/flutter-element) 获取源码
