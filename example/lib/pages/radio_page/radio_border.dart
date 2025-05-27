import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioBorderPreview extends StatefulWidget {
  const RadioBorderPreview({super.key});

  @override
  State<RadioBorderPreview> createState() => _RadioBorderPreviewState();
}

class _RadioBorderPreviewState extends State<RadioBorderPreview> {
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
              const ERadio(value: '1', label: 'option1', border: true),
              const ERadio(value: '2', label: 'option2', border: true),
              const ERadio(value: '3', label: 'option3', border: true),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_border.dart'),
      title: '带边框',
    );
  }
}

class RadioBorderView extends StatefulWidget {
  const RadioBorderView({super.key});

  @override
  State<RadioBorderView> createState() => _RadioBorderViewState();
}

class _RadioBorderViewState extends State<RadioBorderView> {
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
                  const ERadio(value: '1', label: 'option1', border: true),
                  const ERadio(value: '2', label: 'option2', border: true),
                  const ERadio(value: '3', label: 'option3', border: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}