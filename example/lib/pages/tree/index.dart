import 'package:flutter/material.dart';
import 'tree_basic.dart';
import 'tree_checkbox.dart';
import 'tree_default.dart';
import 'tree_disabled.dart';
import 'tree_icon.dart';
import 'tree_draggable.dart';

class TreePreview extends StatelessWidget {
  const TreePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          TreeBasicPreview(),
          TreeCheckboxPreview(),
          TreeDefaultPreview(),
          TreeDisabledPreview(),
          TreeIconPreview(),
          TreeDraggablePreview(),
        ],
      ),
    );
  }
}
