import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                Text(
                  'Flutter Element',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Flutter Element 是一套高质量、风格统一的 Flutter 组件库，致力于为开发者提供一致的视觉体验和高效的开发体验。',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.grey[600]),
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
                    const SizedBox(width: 12),
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
                    const SizedBox(width: 12),
                    Text('表单组件'),
                  ],
                ),
                child: Column(
                  children: [
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
                      onTap: () => Get.toNamed(Routes.autoComplete),
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
                  ],
                ),
              ),
              ECollapsePanel(
                title: const Row(
                  children: [
                    Icon(Icons.menu, size: 25),
                    const SizedBox(width: 12),
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
