import 'package:flutter/material.dart';
import 'radio_basic.dart';
import 'radio_disable.dart';
import 'radio_group.dart';
import 'radio_size.dart';
import 'radio_border.dart';
import 'radio_color.dart';

class RadioPreview extends StatelessWidget {
  const RadioPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('单选框组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            RadioBasicPreview(),
            RadioColorPreview(),
            RadioDisablePreview(),
            RadioGroupPreview(),
            RadioSizePreview(),
            RadioBorderPreview(),
          ],
        ),
      ),
    );
  }
}
