import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioBasicPreview extends StatefulWidget {
  const RadioBasicPreview({super.key});

  @override
  State<RadioBasicPreview> createState() => _RadioBasicPreviewState();
}

class _RadioBasicPreviewState extends State<RadioBasicPreview> {
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
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_basic.dart'),
      title: '基础用法',
    );
  }
}

class RadioBasicView extends StatefulWidget {
  const RadioBasicView({super.key});

  @override
  State<RadioBasicView> createState() => _RadioBasicViewState();
}

class _RadioBasicViewState extends State<RadioBasicView> {
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
