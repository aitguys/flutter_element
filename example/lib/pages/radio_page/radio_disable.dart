import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioDisablePreview extends StatefulWidget {
  const RadioDisablePreview({super.key});

  @override
  State<RadioDisablePreview> createState() => _RadioDisablePreviewState();
}

class _RadioDisablePreviewState extends State<RadioDisablePreview> {
  String value1 = '1';
  String value2 = '1';
  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('单个禁用'),
          const SizedBox(height: 10),
          ERadioGroup(
            value: value1,
            onChanged: (v) => setState(() => value1 = v),
            children: [
              const ERadio(value: '1', label: 'option1', disabled: true),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('整组禁用'),
          const SizedBox(height: 10),
          ERadioGroup(
            value: value2,
            disabled: true,
            onChanged: (v) => setState(() => value2 = v),
            children: [
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_disable.dart'),
      title: '禁用状态',
    );
  }
}

class RadioDisableView extends StatefulWidget {
  const RadioDisableView({super.key});

  @override
  State<RadioDisableView> createState() => _RadioDisableViewState();
}

class _RadioDisableViewState extends State<RadioDisableView> {
  String value1 = '1';
  String value2 = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('单个禁用'),
              const SizedBox(height: 10),
              ERadioGroup(
                value: value1,
                onChanged: (v) => setState(() => value1 = v),
                children: [
                  const ERadio(value: '1', label: 'option1', disabled: true),
                  const ERadio(value: '2', label: 'option2'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('整组禁用'),
              const SizedBox(height: 10),
              ERadioGroup(
                value: value2,
                disabled: true,
                onChanged: (v) => setState(() => value2 = v),
                children: [
                  const ERadio(value: '1', label: 'option1'),
                  const ERadio(value: '2', label: 'option2'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
