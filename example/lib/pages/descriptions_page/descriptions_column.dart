import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DescriptionsColumnPreview extends StatelessWidget {
  const DescriptionsColumnPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('descriptions_page', 'descriptions_column.dart'),
      title: '两列布局',
    );
  }
}

class DescriptionsColumnView extends StatelessWidget {
  const DescriptionsColumnView({super.key});

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
          title: '商品信息',
          column: 2,
          items: [
            EDescriptionItem(label: '商品名', content: Text('iPhone 15')),
            EDescriptionItem(label: '颜色', content: Text('黑色')),
            EDescriptionItem(label: '容量', content: Text('256GB')),
            EDescriptionItem(label: '价格', content: Text('¥6999')),
          ],
        ),
      ],
    ),
  );
}
