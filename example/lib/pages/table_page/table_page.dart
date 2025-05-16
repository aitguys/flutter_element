import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class TablePage extends StatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final List<Map<String, dynamic>> _data = [
    {
      'date': '2024-03-20',
      'name': '张三',
      'address': '北京市朝阳区',
      'tag': '家',
    },
    {
      'date': '2024-03-21',
      'name': '李四',
      'address': '上海市浦东新区',
      'tag': '公司',
    },
    {
      'date': '2024-03-22',
      'name': '王五',
      'address': '广州市天河区',
      'tag': '学校',
    },
  ];

  final List<ETableColumn> _columns = [
    const ETableColumn(
      prop: 'date',
      label: '日期',
      width: 120,
      sortable: true,
    ),
    const ETableColumn(
      prop: 'name',
      label: '姓名',
      width: 100,
    ),
    const ETableColumn(
      prop: 'address',
      label: '地址',
    ),
    ETableColumn(
      prop: 'tag',
      label: '标签',
      width: 100,
      align: TextAlign.center,
      render: (value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value.toString(),
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    ),
  ];

  void _handleSort(String prop, bool ascending) {
    setState(() {
      _data.sort((a, b) {
        final aValue = a[prop];
        final bValue = b[prop];
        return ascending
            ? aValue.toString().compareTo(bValue.toString())
            : bValue.toString().compareTo(aValue.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table 表格'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础表格',
            child: SizedBox(
              height: 300,
              child: ETable(
                data: _data,
                columns: _columns,
              ),
            ),
          ),
          _buildSection(
            title: '带斑马纹表格',
            child: SizedBox(
              height: 300,
              child: ETable(
                data: _data,
                columns: _columns,
                stripe: true,
              ),
            ),
          ),
          _buildSection(
            title: '带边框表格',
            child: SizedBox(
              height: 300,
              child: ETable(
                data: _data,
                columns: _columns,
                border: true,
              ),
            ),
          ),
          _buildSection(
            title: '可排序表格',
            child: SizedBox(
              height: 300,
              child: ETable(
                data: _data,
                columns: _columns,
                border: true,
                stripe: true,
                onSort: _handleSort,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }
}
