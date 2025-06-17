import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TreeDisabledPreview extends StatelessWidget {
  const TreeDisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tree_page', 'tree_disabled.dart'),
      title: '禁用状态',
    );
  }
}

class TreeDisabledView extends StatelessWidget {
  const TreeDisabledView({super.key});

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
    builder: (context) => const FlTree(
      data: [
        FlTreeNode(
          label: '一级 1',
          value: '1',
          disabled: true,
          children: [
            FlTreeNode(
              label: '二级 1-1',
              value: '1-1',
              children: [
                FlTreeNode(label: '三级 1-1-1', value: '1-1-1'),
              ],
            ),
          ],
        ),
      ],
      showCheckbox: true,
    ),
  );
}
