import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class RadioApiPreview extends StatelessWidget {
  const RadioApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('radio_page', 'radio_api.dart'),
      title: 'API',
    );
  }
}

class RadioApiView extends StatelessWidget {
  const RadioApiView({super.key});

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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'API',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      const Text(
        'Radio 属性',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      _buildApiTable([
        ['属性', '说明', '类型', '默认值'],
        ['value', '单选框的值', 'String', '-'],
        ['label', '单选框的标签', 'String', '-'],
        ['disabled', '是否禁用', 'bool', 'false'],
        ['border', '是否显示边框', 'bool', 'false'],
        ['size', '单选框尺寸', 'ERadioSize', 'ERadioSize.medium'],
      ]),
      const SizedBox(height: 20),
      const Text(
        'RadioGroup 属性',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      _buildApiTable([
        ['属性', '说明', '类型', '默认值'],
        ['value', '选中的值', 'String', '-'],
        ['onChanged', '值改变时的回调', 'Function(String)', '-'],
        ['disabled', '是否禁用整组', 'bool', 'false'],
        ['size', '单选框尺寸', 'ERadioSize', 'ERadioSize.medium'],
        ['children', '子元素', 'List<ERadio>', '-'],
      ]),
    ],
  );
}

Widget _buildApiTable(List<List<String>> rows) {
  return Table(
    border: TableBorder.all(color: Colors.grey.shade300),
    columnWidths: const {
      0: FlexColumnWidth(2),
      1: FlexColumnWidth(4),
      2: FlexColumnWidth(2),
      3: FlexColumnWidth(2),
    },
    children: rows.map((row) {
      return TableRow(
        children: row.map((cell) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cell),
          );
        }).toList(),
      );
    }).toList(),
  );
} 