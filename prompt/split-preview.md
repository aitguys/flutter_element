模仿 button_page 的测试用例拆分方式，对 alert_page 组件进行拆分并自动注册route@route.dart @app_pages.dart 
注意
1. 对basic 组件的拆分出去的内容进行去除
2. 拆分出的每个页面应该包含 *****Preview， *****View 两个class， 以及 _viewerContent 一个内部widget
大概结构如下
``` dart
import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class ****Preview extends StatelessWidget {
  const ****Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('****_page', '****_basic.dart'),
      title: '基础用法',
    );
  }
}

class ****View extends StatelessWidget {
  const ****View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Builder(
    builder: (context) => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ],
    ),
  );
}

```
_viewerContent 不应包含说明文字

3. 文件夹应该包含一个route.dart 文件 ，route对应的是****View 而非****Preview

route文件大致格式如下
```dart
import 'package:get/get.dart';
import 'index.dart';
import '**_basic.dart';
import '**_theme.dart';
import '**_close.dart';
import '**_description.dart';
import '**_center.dart';
import '**_api.dart';

abstract class ****Routes {
  static const **** = '/****';
  static const ****Basic = '/****/basic';
  static const ****Theme = '/****/theme';
  static const ****Close = '/****/close';
  static const ****Description = '/****/description';
  static const ****Center = '/****/center';
  static const ****Api = '/****/api';
}

final alertRoutesPages = [
  GetPage(
    name: ****Routes.****,
    page: () => const ****Preview(),
  ),
  GetPage(
    name: ****Routes.****Basic,
    page: () => const ****BasicView(),
  ),
  GetPage(
    name: ****Routes.****Theme,
    page: () => const ****ThemeView(),
  ),
  GetPage(
    name: ****Routes.****Close,
    page: () => const ****CloseView(),
  ),
  GetPage(
    name: ****Routes.****Description,
    page: () => const ****DescriptionView(),
  ),
  GetPage(
    name: ****Routes.****Center,
    page: () => const ****CenterPreview(),
  ),
  GetPage(
    name: ****Routes.****Api,
    page: () => const ****ApiPreview(),
  ),
];

```


4. 文件夹应该包含一个index.dart 文件 ，index是对所有preview组建的预览

index文件大致格式如下： 
```dart

import 'package:flutter/material.dart';
// 拆分出来的子组件
import '**_basic.dart';
import '**_theme.dart';
import '**_close.dart';
import '**_description.dart';
import '**_center.dart';
import '**_api.dart';

class ****Preview extends StatelessWidget {
  const ****Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ****BasicPreview(),
        ****ThemePreview(),
        ****ClosePreview(),
        ****DescriptionPreview(),
        ****CenterPreview(),
        ****ApiPreview(),
      ],
    );
  }
}

```
5. 拆分完成之后的route需要在  example/lib/routes/app_pages.dart 中进行注册
6. 拆分完成之后的根route需要在  example/lib/pages/home/home_page.dart 的 FlNavItem 中进行注册


把文件自动更新到 @dialog_page 文件夹