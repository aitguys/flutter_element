import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import 'package:logger/logger.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
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

  void _onCheck(List<dynamic> checkedKeys) {
    Logger().d('选中的节点: $checkedKeys');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree 树形控件'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '基础用法',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlTree(
              data: data,
            ),
            const SizedBox(height: 40),
            const Text(
              '可选择',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlTree(
              data: data,
              showCheckbox: true,
              onCheck: _onCheck,
            ),
            const SizedBox(height: 40),
            const Text(
              '默认展开和默认选中',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlTree(
              data: data,
              showCheckbox: true,
              defaultExpandAll: true,
              defaultCheckedKeys: ['1-1-1', '2-1-1'],
              onCheck: _onCheck,
            ),
            const SizedBox(height: 40),
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const FlTree(
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
            const SizedBox(height: 40),
            const Text(
              '自定义图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const FlTree(
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
            const SizedBox(height: 40),
            const Text(
              '可拖拽',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlTree(
              data: data,
              draggable: true,
              onDragEnd: (source, target) {
                Logger().d('拖拽源节点: ${source.label}, 目标节点: ${target.label}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
