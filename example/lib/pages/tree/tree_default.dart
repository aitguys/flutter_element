import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import 'package:logger/logger.dart';
import '../../const/index.dart';

class TreeDefaultPreview extends StatelessWidget {
  const TreeDefaultPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('tree_page', 'tree_default.dart'),
      title: '默认展开和默认选中',
    );
  }
}

class TreeDefaultView extends StatelessWidget {
  const TreeDefaultView({super.key});

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

  void onCheck(List<dynamic> checkedKeys) {
    Logger().d('选中的节点: $checkedKeys');
  }

  return Builder(
    builder: (context) => FlTree(
      data: data,
      showCheckbox: true,
      defaultExpandAll: true,
      defaultCheckedKeys: ['1-1-1', '2-1-1'],
      onCheck: onCheck,
    ),
  );
}
