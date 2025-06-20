import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputDefaultColorPreview extends StatelessWidget {
  const InputDefaultColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_defaultColor.dart'),
      title: 'defaultColor 可以指定输入框的默认颜色',
    );
  }
}

class InputDefaultColorView extends StatefulWidget {
  const InputDefaultColorView({super.key});

  @override
  State<InputDefaultColorView> createState() => _InputDefaultColorViewState();
}

class _InputDefaultColorViewState extends State<InputDefaultColorView> {
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
      const Text('borderColor 可以指定输入框的默认颜色'),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        placeholder: '请输入内容',
        colorType: EColorType.success,
        borderColor: Colors.purple,
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        placeholder: '请输入内容',
        customColor: Colors.red,
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        placeholder: '请输入内容',
        customColor: Colors.red,
        showPlaceholderOnTop: true,
      ),
    ],
  );
}
