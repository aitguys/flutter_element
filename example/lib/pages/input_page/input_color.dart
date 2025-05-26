import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import '../../const/index.dart';

class InputColorPreview extends StatelessWidget {
  const InputColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_color.dart'),
      title: 'colorType 可以指定输入框的颜色类型, 也可以通过customColor指定颜色 ',
    );
  }
}

class InputColorView extends StatefulWidget {
  const InputColorView({super.key});

  @override
  State<InputColorView> createState() => _InputColorViewState();
}

class _InputColorViewState extends State<InputColorView> {
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
  TextEditingController textController = TextEditingController();
  return Column(
    children: [
      const Text('defaultColor 可以指定输入框的默认颜色'),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        placeholder: '请输入内容',
        colorType: EColorType.success,
        defaultColor: Colors.purple,
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        placeholder: '请输入内容',
        customColor: Colors.red,
      ),
    ],
  );
}
