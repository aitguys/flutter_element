import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class SelectApiPreview extends StatelessWidget {
  const SelectApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('select_page', 'select_api.dart'),
      title: 'API',
    );
  }
}

class SelectApiView extends StatelessWidget {
  const SelectApiView({super.key});

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
  return Builder(
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 这里可以补充 API 说明， onChange onClear
        ESelect(
          value: value,
          options: options,
          placeholder: '请选择',
          clearable: true,
          onChanged: (value) {
            Loglevel.d('onChange: $value');
          },
          onClear: () {
            Loglevel.d('onClear');
          },
        ),
      ],
    ),
  );
}
