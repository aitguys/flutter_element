# Flutter Element UI

English | [简体中文](README.md)

A Flutter UI component library based on [Element Plus](https://element-plus.org/) design system, designed to accelerate Flutter application development.

## 🚀 Features

- 📦 90% built with [Flutter](https://flutter.dev/) base components for optimal compatibility
- 🎨 Follows Element Plus design specifications for consistent visual experience
- 🌍 Full platform support ([Android](https://developer.android.com/), [iOS](https://developer.apple.com/ios/), [Web](https://flutter.dev/web), [Windows](https://flutter.dev/desktop), [Linux](https://flutter.dev/desktop), [macOS](https://flutter.dev/desktop))
- 🛠 Simple and intuitive API design
- 📱 Responsive layout support
- 🎯 Progressive platform-specific UI adaptation

## 📋 Development Plan

- [x] Basic component development
- [ ] Platform-specific UI adaptation
- [ ] Documentation improvement
- [ ] Example application
- [ ] Unit testing
- [ ] Performance optimization

Initial version expected to be released by the end of May 2024.

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_element: ^0.1.0  # Version TBD
```

## 🎯 Quick Start

```dart
import 'package:flutter_element/flutter_element.dart';

// Button component example
ElementButton(
  type: ElementButtonType.primary,
  onPressed: () {
    // Handle click event
  },
  child: Text('Button'),
)
```

## 📚 Component List

### Basic Components
- [x] [Button](example/lib/pages/button_page/index.dart)
- [x] [Input](example/lib/pages/input_page/index.dart)
- [x] [Select](example/lib/pages/select_page/index.dart)
- [x] [Radio](example/lib/pages/radio_page/index.dart)
- [x] [Checkbox](example/lib/pages/checkbox_page/index.dart)
- [x] [Switch](example/lib/pages/switch_page/index.dart)
- [x] [Slider](example/lib/pages/slider_page/index.dart)
- [x] [Rate](example/lib/pages/rate_page/index.dart)

### Data Display
- [x] [Tag](example/lib/pages/tag_page/index.dart)
- [x] [Progress](example/lib/pages/progress_page/index.dart)
- [x] [Table](example/lib/pages/table_page/index.dart)
- [x] [Pagination](example/lib/pages/pagination_page/index.dart)
- [x] [Timeline](example/lib/pages/timeline_page/index.dart)
- [x] [Tree](example/lib/pages/tree_page/index.dart)

### Feedback Components
- [x] [Dialog](example/lib/pages/dialog_page/index.dart)
- [x] [Message](example/lib/pages/message_page/index.dart)
- [x] [Notification](example/lib/pages/notification_page/index.dart)
- [x] [Loading](example/lib/pages/loading_page/index.dart)
- [x] [Alert](example/lib/pages/alert_page/index.dart)

### Navigation Components
- [x] [Menu](example/lib/pages/menu_page/index.dart)
- [x] [Tabs](example/lib/pages/tabs_page/index.dart)
- [x] [Breadcrumb](example/lib/pages/breadcrumb_page/index.dart)
- [x] [Steps](example/lib/pages/steps_page/index.dart)
- [x] [Dropdown](example/lib/pages/dropdown_page/index.dart)

### Other Components
- [x] [Calendar](example/lib/pages/calendar_page/index.dart)
- [x] [DatePicker](example/lib/pages/date_picker_page/index.dart)
- [x] [TimePicker](example/lib/pages/time_picker_page/index.dart)
- [x] [Upload](example/lib/pages/upload_page/index.dart)
- [x] [Form](example/lib/pages/form_page/index.dart)

## 🤝 Contributing

We welcome contributions! Feel free to submit a [Pull Request](https://github.com/yourusername/flutter_element/pulls) or create an [Issue](https://github.com/yourusername/flutter_element/issues) to help improve this project.

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 🔗 Related Links

- [Element Plus](https://element-plus.org/) - Design inspiration
- [Flutter](https://flutter.dev/) - Development framework
- [Flutter Documentation](https://docs.flutter.dev/) - Official Flutter documentation
- [Dart Documentation](https://dart.dev/guides) - Official Dart documentation 