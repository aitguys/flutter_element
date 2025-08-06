import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DescriptionsSizePreview extends StatelessWidget {
  const DescriptionsSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('descriptions_page', 'descriptions_size.dart'),
      title: '小尺寸',
    );
  }
}

class DescriptionsSizeView extends StatelessWidget {
  const DescriptionsSizeView({super.key});

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
          title: '简要信息',
          size: EDescriptionsSize.small,
          items: [
            EDescriptionItem(label: 'A', content: Text('1')),
            EDescriptionItem(label: 'B', content: Text('2')),
            EDescriptionItem(label: 'C', content: Text('3')),
          ],
        ),
      ],
    ),
  );
} 