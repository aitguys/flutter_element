import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TreeIconPreview extends StatelessWidget {
  const TreeIconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tree_page', 'tree_icon.dart'),
      title: '自定义图标',
    );
  }
}

class TreeIconView extends StatelessWidget {
  const TreeIconView({super.key});

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
      showCheckbox: true,
      data: [
        FlTreeNode(
          label: '一级 1',
          value: '1',
          icon: Icon(Icons.folder, color: Colors.orange),
          children: [
            FlTreeNode(
              label: '二级 1-1',
              value: '1-1',
              icon: Icon(Icons.folder, color: Colors.orange),
              children: [
                FlTreeNode(
                  label: '三级 1-1-1',
                  value: '1-1-1',
                  icon: Icon(Icons.insert_drive_file),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
