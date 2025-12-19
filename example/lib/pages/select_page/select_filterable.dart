import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class SelectFilterablePreview extends StatelessWidget {
  const SelectFilterablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('select_page', 'select_filterable.dart'),
      title: '可输入搜索',
    );
  }
}

class SelectFilterableView extends StatelessWidget {
  const SelectFilterableView({super.key});

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
  String? value1;
  String? value2;
  final List<SelectOption> options = const [
    SelectOption(value: '1', label: '选项1'),
    SelectOption(value: '2', label: '选项2'),
    SelectOption(value: '3', label: '选项3'),
    SelectOption(value: '4', label: '选项4'),
    SelectOption(value: '5', label: '选项5'),
    SelectOption(value: '6', label: '选项6'),
    SelectOption(value: '7', label: '选项7'),
    SelectOption(value: '8', label: '选项8'),
  ];
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '默认不可输入（filterable: false）',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          '点击输入框只能选择选项，不能输入文本进行搜索',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        ESelect(
          value: value1,
          options: options,
          placeholder: '请选择（不可输入）',
          filterable: false,
          onChanged: (value) {
            value1 = value;
          },
        ),
        const SizedBox(height: 30),
        const Text(
          '可输入搜索（filterable: true）',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          '可以输入文本进行搜索过滤选项',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        ESelect(
          value: value2,
          options: options,
          placeholder: '请选择（可输入搜索）',
          filterable: true,
          onChanged: (value) {
            value2 = value;
          },
        ),
      ],
    ),
  );
}
