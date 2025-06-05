import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class SelectHeaderPreview extends StatelessWidget {
  const SelectHeaderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('select_page', 'select_header.dart'),
      title: '自定义头部',
    );
  }
}

class SelectHeaderView extends StatelessWidget {
  const SelectHeaderView({super.key});

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
  List<String>? values;
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESelect(
          value: values,
          options: options,
          multiple: true,
          placeholder: '请选择',
          size: ESizeItem.small,
          onChanged: (v) {},
          header: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Name'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    ),
  );
}
