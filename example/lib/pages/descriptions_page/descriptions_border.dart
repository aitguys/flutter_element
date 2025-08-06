import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DescriptionsBorderPreview extends StatelessWidget {
  const DescriptionsBorderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('descriptions_page', 'descriptions_border.dart'),
      title: '带边框',
    );
  }
}

class DescriptionsBorderView extends StatelessWidget {
  const DescriptionsBorderView({super.key});

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
          title: '订单信息',
          border: true,
          items: [
            EDescriptionItem(label: '订单号', content: Text('20240601001')),
            EDescriptionItem(label: '下单时间', content: Text('2024-06-01')),
            EDescriptionItem(label: '状态', content: Text('已支付')),
            EDescriptionItem(label: '金额', content: Text('¥100.00')),
          ],
        ),
      ],
    ),
  );
}
