import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import '../../logger/logger.dart';

class TagApiPreview extends StatelessWidget {
  const TagApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tag_page', 'tag_api.dart'),
      title: '事件',
    );
  }
}

class TagApiView extends StatelessWidget {
  const TagApiView({super.key});

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
    builder: (context) => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ETag(
          text: '标签',
          icon: const Icon(Icons.check_circle),
          type: EColorType.success,
          closable: true,
          onPressed: () {
            Loglevel.d('onPressed');
          },
          onLongPressed: () {
            Loglevel.d('onLongPressed');
          },
          onClose: () {
            Loglevel.d('onClose');
          },
        ),
      ],
    ),
  );
}
