import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioGroupPreview extends StatefulWidget {
  const RadioGroupPreview({super.key});

  @override
  State<RadioGroupPreview> createState() => _RadioGroupPreviewState();
}

class _RadioGroupPreviewState extends State<RadioGroupPreview> {
  String value = '1';
  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ERadioGroup(
            value: value,
            onChanged: (v) => setState(() => value = v),
            children: [
              const ERadio(value: '1', label: 'optionA'),
              const ERadio(value: '2', label: 'optionB'),
              const ERadio(value: '3', label: 'optionC'),
              const ERadio(value: '4', label: 'optionD'),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_group.dart'),
      title: '单选框组',
    );
  }
}

class RadioGroupView extends StatefulWidget {
  const RadioGroupView({super.key});

  @override
  State<RadioGroupView> createState() => _RadioGroupViewState();
}

class _RadioGroupViewState extends State<RadioGroupView> {
  String value = '1';
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
              ERadioGroup(
                value: value,
                onChanged: (v) => setState(() => value = v),
                children: [
                  const ERadio(value: '1', label: 'optionA'),
                  const ERadio(value: '2', label: 'optionB'),
                  const ERadio(value: '3', label: 'optionC'),
                  const ERadio(value: '4', label: 'optionD'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
