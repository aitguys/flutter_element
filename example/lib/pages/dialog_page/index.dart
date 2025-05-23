import 'package:flutter/material.dart';
import 'dialog_basic.dart';
import 'dialog_custom_content.dart';
import 'dialog_component.dart';
import 'dialog_draggable.dart';

class DialogPreview extends StatelessWidget {
  const DialogPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DialogBasicPreview(),
        DialogCustomContentPreview(),
        DialogComponentPreview(),
        DialogDraggablePreview(),
      ],
    );
  }
}
