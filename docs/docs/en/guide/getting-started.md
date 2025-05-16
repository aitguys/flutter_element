# Getting Started

## Introduction

Flutter Element is a Material Design-based Flutter component library that aims to provide beautiful, easy-to-use, and highly customizable UI components to help developers quickly build cross-platform applications.

## Features

- 🎨 **Material Design** - Follows Google Material Design guidelines
- 📱 **Cross-platform** - Supports iOS, Android, Web, and more
- 🛠️ **Customizable Theme** - Flexible theme configuration system
- 💡 **TypeScript Support** - Complete type definitions
- 📦 **Ready to Use** - Rich set of pre-built components
- 🔧 **Extensible** - Easy-to-extend component system

## Installation

1. Add the dependency to your Flutter project's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_element: ^1.0.0
```

2. Run the following command to install:

```bash
flutter pub get
```

3. Import in your code:

```dart
import 'package:flutter_element/flutter_element.dart';
```

## Basic Usage

Here's a simple example showing how to use Flutter Element's button component:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

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

## Theme Customization

Flutter Element provides flexible theme customization capabilities:

```dart
import 'package:flutter_element/flutter_element.dart';

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

## Next Steps

- Check out the [Components Documentation](/en/components/) to learn more about component usage
- Read about [Theme Customization](/en/guide/theme) to learn how to customize themes
- Visit our [GitHub Repository](https://github.com/your-repo/flutter-element) for source code
