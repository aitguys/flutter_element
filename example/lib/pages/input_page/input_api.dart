import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:flutter_element_example/logger/logger.dart';

class InputApiPreview extends StatelessWidget {
  const InputApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_api.dart'),
      title: 'onFocus, onBlur， onChanged 可以指定输入框的聚焦、失焦、输入内容变化时的回调',
    );
  }
}

class InputApiView extends StatefulWidget {
  const InputApiView({super.key});

  @override
  State<InputApiView> createState() => _InputApiViewState();
}

class _InputApiViewState extends State<InputApiView> {
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
      const Text('onFocus, onBlur， onChanged 可以指定输入框的聚焦、失焦、输入内容变化时的回调'),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 onFocus, onBlur， onChanged',
        onFocus: () {
          Loglevel.d('onFocus');
        },
        onBlur: () {
          Loglevel.d('onBlur');
        },
        onChanged: (value) {
          Loglevel.d('onChanged: $value');
        },
      ),
      // api onFocus, onBlur， onChanged
    ],
  );
}
