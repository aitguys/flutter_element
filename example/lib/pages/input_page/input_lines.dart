import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputLinesPreview extends StatelessWidget {
  const InputLinesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_lines.dart'),
      title: '通过maxlines和minlines控制输入框行数',
    );
  }
}

class InputLinesView extends StatefulWidget {
  const InputLinesView({super.key});

  @override
  State<InputLinesView> createState() => _InputLinesViewState();
}

class _InputLinesViewState extends State<InputLinesView> {
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
      EInput(
        textController: textController,
        maxLines: 8,
        minLines: 6,
        placeholder: '请输入内容',
      ),
    ],
  );
}
