import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteShowPlaceholderPreview extends StatelessWidget {
  const AutocompleteShowPlaceholderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          getCodeUrl('autocomplete_page', 'autocomplete_show_placeholder.dart'),
      title:
          'showPlaceholderOnTop 可以指定聚焦时输入框的placeholder是否显示在输入框的顶部， 文字颜色同bordercolor颜色一样受colorType和customColor影响',
    );
  }
}

class AutocompleteShowPlaceholderView extends StatefulWidget {
  const AutocompleteShowPlaceholderView({super.key});

  @override
  State<AutocompleteShowPlaceholderView> createState() =>
      _AutocompleteShowPlaceholderViewState();
}

class _AutocompleteShowPlaceholderViewState
    extends State<AutocompleteShowPlaceholderView> {
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
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 showPlaceholderOnTop',
        showPlaceholderOnTop: true,
        customColor: Colors.red,
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
      // api onFocus, onBlur， onChanged
    ],
  );
}
