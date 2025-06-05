import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class SelectMultiplePreview extends StatelessWidget {
  const SelectMultiplePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('select_page', 'select_multiple.dart'),
      title: '单选和多选',
    );
  }
}

class SelectMultipleView extends StatelessWidget {
  const SelectMultipleView({super.key});

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
  final List<SelectOption> options = const [
    SelectOption(value: '1', label: '选项1'),
    SelectOption(value: '2', label: '选项2'),
    SelectOption(value: '3', label: '选项3'),
    SelectOption(value: '4', label: '选项4'),
    SelectOption(value: '5', label: '选项5'),
  ];
  String? value;
  List<String>? values;
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESelect(
          value: value,
          options: options,
          placeholder: '请选择 - 单选',
          onChanged: (v) {},
        ),
        const SizedBox(height: 20),
        ESelect(
          value: values,
          options: options,
          placeholder: '请选择 - 多选',
          multiple: true,
          onChanged: (v) {},
        ),
      ],
    ),
  );
}
