import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';
class AutoCompleteBasicPreview extends StatelessWidget {
  const AutoCompleteBasicPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('autocomplete_page', 'autocomplete_basic.dart'),
      title: '基础用法, isPlain, isRound, icon ',
    );
  }
}

class AutoCompleteBasicView extends StatelessWidget {
  const AutoCompleteBasicView({super.key});

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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Basic Autocomplete',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      EAutocomplete(
        placeholder: 'Please input',
        clearable: true,
        disabled: false,
        debounce: 1000,
        size: ESizeItem.small,
        triggerOnFocus: true,
        onChange: (value) {
          Logger().d('onChange: $value');
        },
        fetchSuggestions: (query, callback) {
          final suggestions = [
            {'value': 'vue', 'link': 'https://github.com/vuejs/vue'},
            {'value': 'element', 'link': 'https://github.com/ElemeFE/element'},
            {'value': 'cooking', 'link': 'https://github.com/ElemeFE/cooking'},
            {'value': 'mint-ui', 'link': 'https://github.com/ElemeFE/mint-ui'},
            {'value': 'vuex', 'link': 'https://github.com/vuejs/vuex'},
            {
              'value': 'vue-router',
              'link': 'https://github.com/vuejs/vue-router'
            },
            {'value': 'babel', 'link': 'https://github.com/babel/babel'},
          ];
          callback(suggestions
              .where((item) => item['value']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList());
        },
        onSelect: (item) {
          Logger().d('Selected: $item');
        },
      ),
      const SizedBox(height: 32),
      const Text('Custom Template',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      EAutocomplete(
        placeholder: 'Please input',
        clearable: true,
        fetchSuggestions: (query, callback) {
          final suggestions = [
            {'value': 'vue', 'link': 'https://github.com/vuejs/vue'},
            {'value': 'element', 'link': 'https://github.com/ElemeFE/element'},
            {'value': 'cooking', 'link': 'https://github.com/ElemeFE/cooking'},
            {'value': 'mint-ui', 'link': 'https://github.com/ElemeFE/mint-ui'},
            {'value': 'vuex', 'link': 'https://github.com/vuejs/vuex'},
            {
              'value': 'vue-router',
              'link': 'https://github.com/vuejs/vue-router'
            },
            {'value': 'babel', 'link': 'https://github.com/babel/babel'},
          ];
          callback(suggestions
              .where((item) => item['value']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList());
        },
        onSelect: (item) {
          Logger().d('Selected: ${item['value']}');
        },
        prefix: const Icon(Icons.search),
        suffix: const Icon(Icons.edit),
      ),
      const SizedBox(height: 32),
      const Text('Remote Search',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      EAutocomplete(
        placeholder: 'Please input',
        clearable: true,
        fetchSuggestions: (query, callback) async {
          // Simulate remote search
          await Future.delayed(const Duration(milliseconds: 500));
          final suggestions = [
            {'value': 'vue', 'link': 'https://github.com/vuejs/vue'},
            {'value': 'element', 'link': 'https://github.com/ElemeFE/element'},
            {'value': 'cooking', 'link': 'https://github.com/ElemeFE/cooking'},
            {'value': 'mint-ui', 'link': 'https://github.com/ElemeFE/mint-ui'},
            {'value': 'vuex', 'link': 'https://github.com/vuejs/vuex'},
            {
              'value': 'vue-router',
              'link': 'https://github.com/vuejs/vue-router'
            },
            {'value': 'babel', 'link': 'https://github.com/babel/babel'},
          ];
          callback(suggestions
              .where((item) => item['value']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList());
        },
        onSelect: (item) {
          Logger().d('Selected: ${item['value']}');
        },
      ),
    ],
  );
}
