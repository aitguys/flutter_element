import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteDisablePreview extends StatelessWidget {
  const AutocompleteDisablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_disable.dart'),
      title: 'disabled 可以限制输入框的只读状',
    );
  }
}

class AutocompleteDisableView extends StatefulWidget {
  const AutocompleteDisableView({super.key});

  @override
  State<AutocompleteDisableView> createState() =>
      _AutocompleteDisableViewState();
}

class _AutocompleteDisableViewState extends State<AutocompleteDisableView> {
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
        placeholder: '请输入内容 readOnly',
        disabled: true,
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
