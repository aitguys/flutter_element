import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class AutocompleteBasicPreview extends StatelessWidget {
  const AutocompleteBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('autocomplete_page', 'autocomplete_basic.dart'),
      title:
          '基础用法, 通过size （ ESizeItem） 控制输入框大小， 同样可以使用 customHeight 和 customFontSize 自定义输入框高度和字体大小，customHeight 和 customFontSize 会覆盖 size 的设置',
    );
  }
}

class AutocompleteBasicView extends StatefulWidget {
  const AutocompleteBasicView({super.key});

  @override
  State<AutocompleteBasicView> createState() => _AutocompleteBasicViewState();
}

class _AutocompleteBasicViewState extends State<AutocompleteBasicView> {
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
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  return Column(
    children: [
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController1,
        size: ESizeItem.small,
        placeholder: '请输入内容',
        clearable: true,
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
      const SizedBox(height: 10),
      EAutocomplete(
        textController: textController2,
        size: ESizeItem.medium,
        placeholder: '请输入内容',
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
        textController: textController3,
        size: ESizeItem.large,
        placeholder: '请输入内容',
        fetchSuggestions: (query, callback) {
          callback([
            {'value': '1'},
            {'value': '2'},
            {'value': '3'},
          ]);
        },
      ),
      // 自定义hight
      EAutocomplete(
        textController: textController3,
        size: ESizeItem.large,
        customHeight: 100,
        placeholder: '请输入内容',
        fetchSuggestions: (query, callback) {
          callback([
            {'value': '1'},
            {'value': '2'},
            {'value': '3'},
          ]);
        },
      ),
      EAutocomplete(
        textController: textController3,
        size: ESizeItem.large,
        customHeight: 100,
        customFontSize: 30,
        placeholder: '请输入内容',
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
