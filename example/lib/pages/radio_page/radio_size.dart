import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioSizePreview extends StatefulWidget {
  const RadioSizePreview({super.key});

  @override
  State<RadioSizePreview> createState() => _RadioSizePreviewState();
}

class _RadioSizePreviewState extends State<RadioSizePreview> {
  String value1 = '1';
  String value2 = '1';
  String value3 = '1';
  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('大尺寸'),
          const SizedBox(height: 10),
          ERadioGroup(
            textController: TextEditingController(text: value1),
            size: ESizeItem.large,
            onChanged: (v) => setState(() => value1 = v),
            children: [
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('中尺寸'),
          const SizedBox(height: 10),
          ERadioGroup(
            textController: TextEditingController(text: value2),
            size: ESizeItem.medium,
            onChanged: (v) => setState(() => value2 = v),
            children: [
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('小尺寸'),
          const SizedBox(height: 10),
          ERadioGroup(
            textController: TextEditingController(text: value3),
            size: ESizeItem.small,
            onChanged: (v) => setState(() => value3 = v),
            children: [
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('自定义尺寸'),
          const SizedBox(height: 10),
          ERadioGroup(
            textController: TextEditingController(text: value3),
            customFontSize: 30,
            onChanged: (v) => setState(() => value3 = v),
            children: [
              const ERadio(value: '1', label: 'option1'),
              const ERadio(value: '2', label: 'option2'),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_size.dart'),
      title: '不同尺寸',
    );
  }
}

class RadioSizeView extends StatefulWidget {
  const RadioSizeView({super.key});

  @override
  State<RadioSizeView> createState() => _RadioSizeViewState();
}

class _RadioSizeViewState extends State<RadioSizeView> {
  String value1 = '1';
  String value2 = '1';
  String value3 = '1';
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
              const Text('大尺寸'),
              const SizedBox(height: 10),
              ERadioGroup(
                textController: TextEditingController(text: value1),
                size: ESizeItem.large,
                onChanged: (v) => setState(() => value1 = v),
                children: [
                  const ERadio(value: '1', label: 'option1'),
                  const ERadio(value: '2', label: 'option2'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('中尺寸'),
              const SizedBox(height: 10),
              ERadioGroup(
                textController: TextEditingController(text: value2),
                size: ESizeItem.medium,
                onChanged: (v) => setState(() => value2 = v),
                children: [
                  const ERadio(value: '1', label: 'option1'),
                  const ERadio(value: '2', label: 'option2'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('小尺寸'),
              const SizedBox(height: 10),
              ERadioGroup(
                textController: TextEditingController(text: value3),
                size: ESizeItem.small,
                onChanged: (v) => setState(() => value3 = v),
                children: [
                  const ERadio(value: '1', label: 'option1'),
                  const ERadio(value: '2', label: 'option2'),
                ],
              ),
              const Text('自定义尺寸'),
              const SizedBox(height: 10),
              ERadioGroup(
                textController: TextEditingController(text: value3),
                customFontSize: 30,
                onChanged: (v) => setState(() => value3 = v),
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
