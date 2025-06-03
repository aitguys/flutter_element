# Flutter Element UI

[English](README_EN.md) | 简体中文

基于 [Element Plus](https://element-plus.org/) 设计风格的 Flutter UI 组件库，旨在加速 Flutter 应用开发。

## 🚧 正在开发

该组件仍然在开发状态，预计 6 月底有稳定版本上线

## 🚀 特性

- 📦 90% 使用 [Flutter](https://flutter.dev/) 基础组件构建，确保最佳兼容性
- 🎨 遵循 Element Plus 设计规范，提供一致的视觉体验
- 🌍 全平台支持（[Android](https://developer.android.com/)、[iOS](https://developer.apple.com/ios/)、[Web](https://flutter.dev/web)、[Windows](https://flutter.dev/desktop)、[Linux](https://flutter.dev/desktop)、[macOS](https://flutter.dev/desktop)）
- 🛠 简单易用的 API 设计
- 📱 响应式布局支持
- 🎯 渐进式平台特定 UI 适配

## 📋 开发计划

- [x] 基础组件开发
- [ ] 平台特定 UI 适配
- [ ] 文档完善
- [ ] 示例应用
- [ ] 单元测试
- [ ] 性能优化

## 📦 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  flutter_element: ^0.1.0 # 版本号待定
```

## 🎯 快速开始

```dart
import 'package:flutter_element_plus/flutter_element_plus.dart';

// 使用按钮组件示例
ElementButton(
  type: ElementButtonType.primary,
  onPressed: () {
    // 处理点击事件
  },
  child: Text('按钮'),
)
```

## 📚 组件列表

### 基础组件

- [x] [Button 按钮](example/lib/pages/button_page/index.dart)
- [x] [Input 输入框](example/lib/pages/input_page/index.dart)
- [x] [Select 选择器](example/lib/pages/select_page/index.dart)
- [x] [Radio 单选框](example/lib/pages/radio_page/index.dart)
- [x] [Checkbox 多选框](example/lib/pages/checkbox_page/index.dart)
- [x] [Switch 开关](example/lib/pages/switch_page/index.dart)
- [x] [Slider 滑块](example/lib/pages/slider_page/index.dart)
- [x] [Rate 评分](example/lib/pages/rate_page/index.dart)

### 数据展示

- [x] [Tag 标签](example/lib/pages/tag_page/index.dart)
- [x] [Progress 进度条](example/lib/pages/progress_page/index.dart)
- [x] [Table 表格](example/lib/pages/table_page/index.dart)
- [x] [Pagination 分页](example/lib/pages/pagination_page/index.dart)
- [x] [Timeline 时间线](example/lib/pages/timeline_page/index.dart)
- [x] [Tree 树形控件](example/lib/pages/tree_page/index.dart)

### 反馈组件

- [x] [Dialog 对话框](example/lib/pages/dialog_page/index.dart)
- [x] [Message 消息提示](example/lib/pages/message_page/index.dart)
- [x] [Notification 通知](example/lib/pages/notification_page/index.dart)
- [x] [Loading 加载](example/lib/pages/loading_page/index.dart)
- [x] [Alert 警告](example/lib/pages/alert_page/index.dart)

### 导航组件

- [x] [Menu 菜单](example/lib/pages/menu_page/index.dart)
- [x] [Tabs 标签页](example/lib/pages/tabs_page/index.dart)
- [x] [Breadcrumb 面包屑](example/lib/pages/breadcrumb_page/index.dart)
- [x] [Steps 步骤条](example/lib/pages/steps_page/index.dart)
- [x] [Dropdown 下拉菜单](example/lib/pages/dropdown_page/index.dart)

### 其他组件

- [x] [Calendar 日历](example/lib/pages/calendar_page/index.dart)
- [x] [DatePicker 日期选择器](example/lib/pages/date_picker_page/index.dart)
- [x] [TimePicker 时间选择器](example/lib/pages/time_picker_page/index.dart)
- [x] [Upload 上传](example/lib/pages/upload_page/index.dart)
- [x] [Form 表单](example/lib/pages/form_page/index.dart)

## 🤝 贡献指南

欢迎提交 [Pull Request](https://github.com/yourusername/flutter_element/pulls) 或创建 [Issue](https://github.com/yourusername/flutter_element/issues) 来帮助改进这个项目。

## 📄 开源协议

本项目采用 [MIT License](LICENSE) 开源协议。

## 🔗 相关链接

- [Element Plus](https://element-plus.org/) - 设计灵感来源
- [Flutter](https://flutter.dev/) - 开发框架
- [Flutter 中文网](https://flutter.cn/) - Flutter 中文资源
- [Dart 中文网](https://dart.cn/) - Dart 语言中文资源
