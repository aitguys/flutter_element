import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:flutter_element_example/logger/logger.dart';

class AutocompleteApiPreview extends StatelessWidget {
  const AutocompleteApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('autocomplete_page', 'autocomplete_api.dart'),
      title: 'onFocus, onBlur， onChanged 可以指定输入框的聚焦、失焦、输入内容变化时的回调',
    );
  }
}

class AutocompleteApiView extends StatefulWidget {
  const AutocompleteApiView({super.key});

  @override
  State<AutocompleteApiView> createState() => _AutocompleteApiViewState();
}

class _AutocompleteApiViewState extends State<AutocompleteApiView> {
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
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容 onFocus, onBlur， onChanged',
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
        onFocus: () {
          Loglevel.d('onFocus');
        },
        onBlur: () {
          Loglevel.d('onBlur');
        },
        onChange: (value) {
          Loglevel.d('onChange: $value');
        },
        onSelect: (value) {
          Loglevel.d('onSelect: $value');
        },
        onClear: () {
          Loglevel.d('onClear');
        },
      ),
      // api onFocus, onBlur， onChanged
    ],
  );
}
