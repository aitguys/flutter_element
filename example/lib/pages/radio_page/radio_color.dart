import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RadioColorPreview extends StatefulWidget {
  const RadioColorPreview({super.key});

  @override
  State<RadioColorPreview> createState() => _RadioColorPreviewState();
}

class _RadioColorPreviewState extends State<RadioColorPreview> {
  String value = '1';
  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ERadioGroup(
            textController: TextEditingController(text: value),
            onChanged: (v) => setState(() {
              value = v;
              Loglevel.d(v);
            }),
            children: [
              const ERadio(
                value: '1',
                label: 'option1',
                border: true,
                fontColorType: EColorType.warning,
                fontCustomColor: Colors.black,
                iconColorType: EColorType.primary,
                iconCustomColor: Colors.red,
              ),
              const ERadio(
                value: '2',
                label: 'option2',
                fontColorType: EColorType.warning,
                fontCustomColor: Colors.black,
                iconColorType: EColorType.primary,
                iconCustomColor: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('也可以把属性定义在ERadioGroup中，这样所有子元素都会继承这些属性'),
          const SizedBox(height: 10),
          ERadioGroup(
            textController: TextEditingController(text: value),
            fontColorType: EColorType.warning,
            fontCustomColor: Colors.black,
            iconColorType: EColorType.primary,
            iconCustomColor: Colors.red,
            onChanged: (v) => setState(() {
              value = v;
              Loglevel.d(v);
            }),
            children: [
              const ERadio(
                value: '1',
                label: 'option1',
              ),
              const ERadio(
                value: '2',
                label: 'option2',
              ),
            ],
          ),
        ],
      ),
      code: getCodeUrl('radio_page', 'radio_color.dart'),
      title: '颜色，可以通过colortype 和 customcolor 来分别设置icon 和 文字的颜色颜色',
    );
  }
}

class RadioColorView extends StatefulWidget {
  const RadioColorView({super.key});

  @override
  State<RadioColorView> createState() => _RadioColorViewState();
}

class _RadioColorViewState extends State<RadioColorView> {
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
                textController: TextEditingController(text: value),
                onChanged: (v) => setState(() => value = v),
                children: [
                  const ERadio(
                    value: '1',
                    label: 'option1',
                    fontColorType: EColorType.warning,
                    fontCustomColor: Colors.black,
                    iconColorType: EColorType.primary,
                    iconCustomColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
