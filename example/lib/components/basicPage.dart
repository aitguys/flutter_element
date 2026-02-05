import 'package:flutter/material.dart';

class BasicPageHeader extends StatelessWidget {
  final Widget body;
  final String title;

  const BasicPageHeader({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
    );
  }
}
