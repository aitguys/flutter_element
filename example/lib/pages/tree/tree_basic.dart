import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TreeBasicPreview extends StatelessWidget {
  const TreeBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tree_page', 'tree_basic.dart'),
      title: '基础用法',
    );
  }
}

class TreeBasicView extends StatelessWidget {
  const TreeBasicView({super.key});

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
  final List<FlTreeNode> data = [
    const FlTreeNode(
      label: '一级 1',
      value: '1',
      children: [
        FlTreeNode(
          label: '二级 1-1',
          value: '1-1',
          children: [
            FlTreeNode(label: '三级 1-1-1', value: '1-1-1'),
            FlTreeNode(label: '三级 1-1-2', value: '1-1-2'),
          ],
        ),
      ],
    ),
    const FlTreeNode(
      label: '一级 2',
      value: '2',
      children: [
        FlTreeNode(
          label: '二级 2-1',
          value: '2-1',
          children: [
            FlTreeNode(label: '三级 2-1-1', value: '2-1-1'),
            FlTreeNode(label: '三级 2-1-2', value: '2-1-2'),
          ],
        ),
        FlTreeNode(
          label: '二级 2-2',
          value: '2-2',
          children: [
            FlTreeNode(label: '三级 2-2-1', value: '2-2-1'),
          ],
        ),
      ],
    ),
  ];

  return Builder(
    builder: (context) => FlTree(
      data: data,
      defaultExpandAll: true,
      onNodeClick: (value, isExpanded) {
        debugPrint('点击节点: $value, 是否展开: $isExpanded');
      },
    ),
  );
}
