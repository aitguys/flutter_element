# Installation

## Requirements

- Flutter SDK: 2.0.0 or higher
- Dart SDK: 2.12.0 or higher

## Install with pub

1. Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_element: ^1.0.0
```

2. Run the following command:

```bash
flutter pub get
```

## Manual Installation

1. Clone the repository:

```bash
git clone https://github.com/your-repo/flutter-element.git
```

2. Add local dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_element:
    path: ../flutter-element
```

3. Run the following command:

```bash
flutter pub get
```

## Verify Installation

Import and use in your code:

```dart
import 'package:flutter_element/flutter_element.dart';

// Use button component
ElButton(
  type: ElButtonType.primary,
  child: Text('Primary Button'),
  onPressed: () {
    print('Button pressed!');
  },
)
```

## Next Steps

- [Quick Start](/en/guide/getting-started) - Learn how to use Flutter Element
- [Components](/en/components/) - Browse all available components
