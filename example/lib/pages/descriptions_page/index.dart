import 'package:flutter/material.dart';
import 'descriptions_basic.dart';
import 'descriptions_border.dart';
import 'descriptions_column.dart';
import 'descriptions_size.dart';

class DescriptionsPreview extends StatelessWidget {
  const DescriptionsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descriptions 描述列表'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DescriptionsBasicPreview(),
            DescriptionsBorderPreview(),
            DescriptionsColumnPreview(),
            DescriptionsSizePreview(),
          ],
        ),
      ),
    );
  }
}
