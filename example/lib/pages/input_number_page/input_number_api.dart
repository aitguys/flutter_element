import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberApiPreview extends StatelessWidget {
  const InputNumberApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_api.dart'),
      title: 'API， onChange onFocus onBlur 看看控制台变化',
    );
  }
}

class InputNumberApiView extends StatelessWidget {
  const InputNumberApiView({super.key});

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
                  debugPrint('onChange: $v');
                  setState(() => value = v);
                },
                onFocus: () => debugPrint('onFocus'),
                onBlur: () => debugPrint('onBlur'),
              ),
            ],
          );
        },
      );
    },
  );
}
