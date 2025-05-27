import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class InputFixPreview extends StatelessWidget {
  const InputFixPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_fix.dart'),
      title: 'prefix,suffix 用法， 通过prefix和suffix 在输入框组件的前部或者后部添加图标或任何组件内容',
    );
  }
}

class InputFixView extends StatefulWidget {
  const InputFixView({super.key});

  @override
  State<InputFixView> createState() => _InputFixViewState();
}

class _InputFixViewState extends State<InputFixView> {
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
      const Text('prefix,suffix 用法， 通过prefix和suffix 添加图标或任何组件内容'),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        prefix: const Icon(Icons.search),
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        suffix: const Icon(Icons.search),
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        prefix: Container(
          width: 20,
          height: 20,
          color: Colors.red,
        ),
      ),
    ],
  );
}
