import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputShowPlaceholderPreview extends StatelessWidget {
  const InputShowPlaceholderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_basic.dart'),
      title: '基础用法, isPlain, isRound, icon ',
    );
  }
}

class InputShowPlaceholderView extends StatefulWidget {
  const InputShowPlaceholderView({super.key});

  @override
  State<InputShowPlaceholderView> createState() =>
      _InputShowPlaceholderViewState();
}

class _InputShowPlaceholderViewState extends State<InputShowPlaceholderView> {
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
      const Text(
          'showPlaceholderOnTop 可以指定聚焦时输入框的placeholder是否显示在输入框的顶部， 文字颜色同bordercolor颜色一样受colorType和customColor影响'),
      const SizedBox(height: 10),
      EInput(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 showPlaceholderOnTop',
        showPlaceholderOnTop: true,
        customColor: Colors.red,
      ),
      // api onFocus, onBlur， onChanged
    ],
  );
}
