import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class InputBasicPreview extends StatelessWidget {
  const InputBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_basic.dart'),
      title: '基础用法, 通过size控制输入框大小 ',
    );
  }
}

class InputBasicView extends StatefulWidget {
  const InputBasicView({super.key});

  @override
  State<InputBasicView> createState() => _InputBasicViewState();
}

class _InputBasicViewState extends State<InputBasicView> {
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
        size: ESizeItem.small,
        placeholder: '请输入内容',
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
      ),
    ],
  );
}
