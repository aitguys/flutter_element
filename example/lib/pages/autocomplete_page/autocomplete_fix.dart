import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteFixPreview extends StatelessWidget {
  const AutocompleteFixPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('autocomplete_page', 'autocomplete_fix.dart'),
      title:
          'prefix,suffix,prepend, append 用法， 通过prefix和suffix 在输入框组件的前部或者后部添加图标或任何组件内容,prepend, append  相较于prefix和sufix会有一个默认背景，但是prefix sufix 基本可以覆盖所有需求',
    );
  }
}

class AutocompleteFixView extends StatefulWidget {
  const AutocompleteFixView({super.key});

  @override
  State<AutocompleteFixView> createState() => _AutocompleteFixViewState();
}

class _AutocompleteFixViewState extends State<AutocompleteFixView> {
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
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        prefix: const Icon(Icons.monetization_on),
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        suffix: const Icon(Icons.search),
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        prepend: const Icon(Icons.search),
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
        clearable: true,
        append: const Icon(Icons.search),
        fetchSuggestions: (query, callback) {
          callback([
            {'value': 'nihao'},
            {'value': 'nihao2'},
            {'value': 'nihao3'},
          ]);
        },
      ),
    ],
  );
}
