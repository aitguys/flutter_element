import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class RateHalfPreview extends StatelessWidget {
  const RateHalfPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('rate_page', 'rate_half.dart'),
      title: '允许半选',
    );
  }
}

class RateHalfView extends StatelessWidget {
  const RateHalfView({super.key});

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
          double rate = 0;
          return ERate(
            value: rate,
            allowHalf: true,
            onChanged: (value) => setState(() => rate = value),
          );
        },
      );
    },
  );
}
