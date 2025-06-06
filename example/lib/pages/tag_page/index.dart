import 'package:flutter/material.dart';
import 'tag_basic.dart';
import 'tag_removable.dart';
import 'tag_size.dart';
import 'tag_theme.dart';
import 'tag_custom_color.dart';
import 'tag_icon.dart';
import 'tag_custom_content.dart';
import 'tag_api.dart';

class TagPreview extends StatelessWidget {
  const TagPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TagBasicPreview(),
          TagRemovablePreview(),
          TagSizePreview(),
          TagThemePreview(),
          TagCustomColorPreview(),
          TagIconPreview(),
          TagCustomContentPreview(),
          TagApiPreview(),
        ],
      ),
    );
  }
}
