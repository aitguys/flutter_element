import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class InputDisablePreview extends StatelessWidget {
  const InputDisablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_disable.dart'),
      title: 'readOnly 和 disabled 可以限制输入框的只读状态，区别如下',
    );
  }
}

class InputDisableView extends StatefulWidget {
  const InputDisableView({super.key});

  @override
  State<InputDisableView> createState() => _InputDisableViewState();
}

class _InputDisableViewState extends State<InputDisableView> {
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
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 readOnly',
        readOnly: true,
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 disabled',
        disabled: true,
      ),
    ],
  );
}
