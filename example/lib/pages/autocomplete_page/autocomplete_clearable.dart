import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteClearablePreview extends StatelessWidget {
  const AutocompleteClearablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('autocomplete_page', 'autocomplete_clearable.dart'),
      title: 'clearable 可以清除输入框内容 ',
    );
  }
}

class AutocompleteClearableView extends StatefulWidget {
  const AutocompleteClearableView({super.key});

  @override
  State<AutocompleteClearableView> createState() =>
      _AutocompleteClearableViewState();
}

class _AutocompleteClearableViewState extends State<AutocompleteClearableView> {
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
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 clearable',
        clearable: true,
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
      // showPlaceholderOnTop 可以指定输入框的placeholder是否显示在输入框的顶部
      // api onFocus, onBlur， onChanged
    ],
  );
}
