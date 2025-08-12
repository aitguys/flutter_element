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
          title: 'User Info - direction: horizontal',
          itemLabelFontSize: 16,
          itemContentFontSize: 16,
          items: [
            EDescriptionItem(label: 'Username', content: Text('zhangsan')),
            EDescriptionItem(
                label: 'Phone Number', content: Text('12345678901')),
            EDescriptionItem(label: 'Address', content: Text('北京市朝阳区')),
            EDescriptionItem(label: 'Remark', content: Text('VIP用户')),
            EDescriptionItem(label: 'Address', content: Text('北京市朝阳区')),
          ],
        ),
        EDescriptions(
          title: 'User Info - direction: vertical',
          direction: EDescriptionsDirection.vertical,
          items: [
            EDescriptionItem(label: 'Username', content: Text('zhangsan')),
            EDescriptionItem(
                label: 'Phone Number', content: Text('12345678901')),
            EDescriptionItem(label: 'Address', content: Text('北京市朝阳区')),
            EDescriptionItem(label: 'Remark', content: Text('VIP用户')),
            EDescriptionItem(label: 'Address', content: Text('北京市朝阳区')),
          ],
        ),
      ],
    ),
  );
}
