import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberPrefixSuffixPreview extends StatelessWidget {
  const InputNumberPrefixSuffixPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_prefix_suffix.dart'),
      title: '前缀和后缀',
    );
  }
}

class InputNumberPrefixSuffixView extends StatelessWidget {
  const InputNumberPrefixSuffixView({super.key});

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
  return Builder(
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          double? value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EInputNumber(
                value: value,
                onChanged: (v) {
                  setState(() => value = v);
                },
                prefix: const Text('￥'),
                suffix: const Icon(Icons.check_circle,
                    size: 18, color: Colors.green),
              ),
            ],
          );
        },
      );
    },
  );
}
