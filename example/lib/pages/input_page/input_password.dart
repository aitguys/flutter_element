import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputPasswordPreview extends StatelessWidget {
  const InputPasswordPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_basic.dart'),
      title: 'password 密码输入框',
    );
  }
}

class InputPasswordView extends StatefulWidget {
  const InputPasswordView({super.key});

  @override
  State<InputPasswordView> createState() => _InputPasswordViewState();
}

class _InputPasswordViewState extends State<InputPasswordView> {
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
        password: true,
        placeholder: '请输入密码',
      ),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        password: true,
        placeholder: '请输入密码',
      ),
    ],
  );
}
