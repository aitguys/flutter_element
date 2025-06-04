import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class InputNumberSizePreview extends StatelessWidget {
  const InputNumberSizePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('inputNumber', 'input_number_size.dart'),
      title: '不同尺寸',
    );
  }
}

class InputNumberSizeView extends StatelessWidget {
  const InputNumberSizeView({super.key});

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
          double? value1, value2, value3, value4;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: EInputNumber(
                      value: value1,
                      onChanged: (v) {
                        setState(() => value1 = v);
                      },
                      size: ESizeItem.small,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EInputNumber(
                      value: value2,
                      onChanged: (v) {
                        setState(() => value2 = v);
                      },
                      size: ESizeItem.medium,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EInputNumber(
                      value: value3,
                      onChanged: (v) {
                        setState(() => value3 = v);
                      },
                      size: ESizeItem.large,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: EInputNumber(
                      value: value4,
                      placeholder: '自定义高度会覆盖 size 的设置',
                      onChanged: (v) {
                        setState(() => value4 = v);
                      },
                      customHeight: 40,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
