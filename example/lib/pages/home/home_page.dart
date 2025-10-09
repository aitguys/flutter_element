import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        children: [
          // 顶部介绍
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Flutter Element',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      EButton(
                        text: 'www.flutter-element.com',
                        isLink: true,
                        type: EColorType.primary,
                        onPressed: () async {
                          try {
                            final url =
                                Uri.parse('https://www.flutter-element.com');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          } catch (e) {
                            debugPrint('无法打开URL: $e');
                          }
                        },
                      ),
                      // 网址 www.flutter-element.com

                      const SizedBox(height: 12),

                      Text(
                        'Flutter Element 是一套高质量、风格统一的 Flutter 组件库，致力于为开发者提供一致的视觉体验和高效的开发体验。',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ECollapse(
            panels: [
              ECollapsePanel(
                title: const Row(
                  children: [
                    Icon(Icons.menu, size: 25),
                    SizedBox(width: 12),
                    Text('基础组件'),
                  ],
                ),
                child: Column(
                  children: [
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.button),
                      child: const Text('Button 按钮',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.link),
                      child:
                          const Text('Link 链接', style: TextStyle(fontSize: 15)),
                    ),
                    // Tab
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.tabs),
                      child:
                          const Text('Tab 标签', style: TextStyle(fontSize: 15)),
                    ),
                    // FlNavItem(
                    //   suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                    //   padding: const EdgeInsets.symmetric(horizontal: 4),
                    //   onTap: () => Get.toNamed(Routes.navItem),
                    //   child: const Text('NavItem 导航栏',
                    //       style: TextStyle(fontSize: 15)),
                    // ),
                    // FlNavItem(
                    //   suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                    //   padding: const EdgeInsets.symmetric(horizontal: 4),
                    //   onTap: () => Get.toNamed(Routes.widgetPreview),
                    //   child: const Text('WidgetPreview 组件预览',
                    //       style: TextStyle(fontSize: 15)),
                    // ),
                  ],
                ),
              ),
              ECollapsePanel(
                title: const Row(
                  children: [
                    Icon(Icons.menu, size: 25),
                    SizedBox(width: 12),
                    Text('表单组件'),
                  ],
                ),
                child: Column(
                  children: [
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.form),
                      child:
                          const Text('Form 表单', style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.input),
                      child: const Text('Input 输入框',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.autocomplete),
                      child: const Text('AutoComplete 自动补全',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.radio),
                      child: const Text('Radio 单选框',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.rate),
                      child:
                          const Text('Rate 评分', style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.checkbox),
                      child: const Text('Checkbox 多选框',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.datePicker),
                      child: const Text('DatePicker 日期选择器',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.inputNumber),
                      child: const Text('InputNumber 数字输入框',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.inputTag),
                      child: const Text('InputTag 标签输入框',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.select),
                      child: const Text('Select 选择器',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.colorPicker),
                      child: const Text('ColorPicker 颜色选择器',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.progress),
                      child: const Text('Progress 进度条',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.timePicker),
                      child: const Text('TimePicker 时间选择器',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
              ECollapsePanel(
                title: const Row(
                  children: [
                    Icon(Icons.menu, size: 25),
                    SizedBox(width: 12),
                    Text('反馈组件'),
                  ],
                ),
                child: Column(
                  children: [
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.message),
                      child: const Text('Message 消息',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.alert),
                      child: const Text('Alert 提示',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.dialog),
                      child: const Text('Dialog 对话框',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
              ECollapsePanel(
                title: const Row(
                  children: [
                    Icon(Icons.menu, size: 25),
                    SizedBox(width: 12),
                    Text('其他组件'),
                  ],
                ),
                child: Column(
                  children: [
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.datePicker),
                      child: const Text('DatePicker 日期选择器',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.avatar),
                      child: const Text('Avatar 头像',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.image),
                      child: const Text('Image 图片',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.card),
                      child:
                          const Text('Card 卡片', style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.descriptions),
                      child: const Text('Descriptions 描述列表',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.tree),
                      child: const Text('Tree 树形控件',
                          style: TextStyle(fontSize: 15)),
                    ),
                    FlNavItem(
                      suffix: const Icon(Icons.arrow_forward_ios, size: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: () => Get.toNamed(Routes.pagination),
                      child: const Text('Pagination 分页',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 组件分组1
        ],
      ),
    );
  }
}
