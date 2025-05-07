import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class AutocompletePage extends StatelessWidget {
  const AutocompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              size: SizeItem.small,
              triggerOnFocus: true,
              onChange: (value) {
                print('onChange: $value');
              },
              fetchSuggestions: (query, callback) {
                final suggestions = [
                  {'value': 'vue', 'link': 'https://github.com/vuejs/vue'},
                  {
                    'value': 'element',
                    'link': 'https://github.com/ElemeFE/element'
                  },
                  {
                    'value': 'cooking',
                    'link': 'https://github.com/ElemeFE/cooking'
                  },
                  {
                    'value': 'mint-ui',
                    'link': 'https://github.com/ElemeFE/mint-ui'
                  },
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
                print('Selected: ${item}');
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
                  {
                    'value': 'element',
                    'link': 'https://github.com/ElemeFE/element'
                  },
                  {
                    'value': 'cooking',
                    'link': 'https://github.com/ElemeFE/cooking'
                  },
                  {
                    'value': 'mint-ui',
                    'link': 'https://github.com/ElemeFE/mint-ui'
                  },
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
                print('Selected: ${item['value']}');
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
                  {
                    'value': 'element',
                    'link': 'https://github.com/ElemeFE/element'
                  },
                  {
                    'value': 'cooking',
                    'link': 'https://github.com/ElemeFE/cooking'
                  },
                  {
                    'value': 'mint-ui',
                    'link': 'https://github.com/ElemeFE/mint-ui'
                  },
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
                print('Selected: ${item['value']}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
