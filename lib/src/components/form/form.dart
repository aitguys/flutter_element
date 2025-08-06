// lib/src/components/button/button.dart
import 'package:flutter/material.dart';

class EForm extends StatefulWidget {
  final List<Widget> children;
  const EForm({
    super.key,
    required this.children,
  });

  @override
  State<EForm> createState() => _EFormState();
}

class _EFormState extends State<EForm> {
  @override
  Widget build(BuildContext context) {
    Widget btn = Column(children: widget.children);

    return btn;
  }
}
