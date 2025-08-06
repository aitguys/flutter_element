import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DescriptionsBasicPreview extends StatelessWidget {
  const DescriptionsBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('descriptions_page', 'descriptions_basic.dart'),
      title: '基础用法',
    );
  }
}

class DescriptionsBasicView extends StatelessWidget {
  const DescriptionsBasicView({super.key});

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
        EDescriptions(
          title: '用户信息',
          items: [
            EDescriptionItem(label: '用户名', content: Text('张三')),
            EDescriptionItem(label: '手机号', content: Text('12345678901')),
            EDescriptionItem(label: '住址', content: Text('北京市朝阳区')),
            EDescriptionItem(label: '备注', content: Text('VIP用户')),
          ],
        ),
      ],
    ),
  );
}
