import 'package:flutter/material.dart';
import 'autocomplete_basic.dart';

class AutoCompletePreview extends StatelessWidget {
  const AutoCompletePreview({super.key});

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
            AutoCompleteBasicPreview(),
          ],
        ),
      ),
    );
  }
}
