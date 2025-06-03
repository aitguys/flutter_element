import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteDefaultColorPreview extends StatelessWidget {
  const AutocompleteDefaultColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_defaultColor.dart'),
      title: 'defaultColor 可以指定输入框的默认颜色',
    );
  }
}

class AutocompleteDefaultColorView extends StatefulWidget {
  const AutocompleteDefaultColorView({super.key});

  @override
  State<AutocompleteDefaultColorView> createState() =>
      _AutocompleteDefaultColorViewState();
}

class _AutocompleteDefaultColorViewState
    extends State<AutocompleteDefaultColorView> {
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
      const Text('defaultColor 可以指定输入框的默认颜色'),
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController,
        placeholder: '请输入内容',
        colorType: EColorType.success,
        defaultColor: Colors.purple,
        fetchSuggestions: (query, callback) {
          callback([
            {'value': '1'},
            {'value': '2'},
            {'value': '3'},
          ]);
        },
      ),
    ],
  );
}
