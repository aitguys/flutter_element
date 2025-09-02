import 'package:flutter/material.dart';
import 'form_basic.dart';
import '../../utils/index.dart';

class FormPreview extends StatelessWidget {
  const FormPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组件'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => backToHome(context),
        ),
      ),
      body: const FormBasicView(),
    );
  }
}
