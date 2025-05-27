import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';

class InputClearablePreview extends StatelessWidget {
  const InputClearablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_clearable.dart'),
      title: 'clearable 可以清除输入框内容 ',
    );
  }
}

class InputClearableView extends StatefulWidget {
  const InputClearableView({super.key});

  @override
  State<InputClearableView> createState() => _InputClearableViewState();
}

class _InputClearableViewState extends State<InputClearableView> {
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
        placeholder: '请输入内容 clearable',
        clearable: true,
      ),
      // showPlaceholderOnTop 可以指定输入框的placeholder是否显示在输入框的顶部
      // api onFocus, onBlur， onChanged
    ],
  );
}
