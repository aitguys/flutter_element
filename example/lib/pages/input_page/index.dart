import 'package:flutter/material.dart';
import 'input_basic.dart';
import 'input_color.dart';
import 'input_fix.dart';
import 'input_clearable.dart';
import 'input_disable.dart';
import 'input_default_color.dart';
import 'input_password.dart';

class InputPreview extends StatelessWidget {
  const InputPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            InputBasicPreview(),
            InputColorPreview(),
            InputFixPreview(),
            InputClearablePreview(),
            InputDisablePreview(),
            InputDefaultColorPreview(),
            InputPasswordPreview(),
          ],
        ),
      ),
    );
  }
}
