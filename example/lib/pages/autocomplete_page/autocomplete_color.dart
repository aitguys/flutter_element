import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteColorPreview extends StatelessWidget {
  const AutocompleteColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('input_page', 'input_color.dart'),
      title:
          'colorType 可以指定输入框的颜色类型, 也可以通过customColor指定borderColor, customColor 会覆盖 colorType 的设置',
    );
  }
}

class AutocompleteColorView extends StatefulWidget {
  const AutocompleteColorView({super.key});

  @override
  State<AutocompleteColorView> createState() => _AutocompleteColorViewState();
}

class _AutocompleteColorViewState extends State<AutocompleteColorView> {
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
        fetchSuggestions: (query, callback) {
          callback([
            {'value': '1'},
            {'value': '2'},
            {'value': '3'},
          ]);
        },
      ),
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController,
        placeholder: '请输入内容',
        colorType: EColorType.success,
        customColor: Colors.red,
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
