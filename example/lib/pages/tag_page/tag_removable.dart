import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class TagRemovablePreview extends StatelessWidget {
  const TagRemovablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: const TagRemovableDemo(),
      code: getCodeUrl('tag_page', 'tag_removable.dart'),
      title: '可移除标签',
    );
  }
}

class TagRemovableView extends StatefulWidget {
  const TagRemovableView({super.key});

  @override
  State<TagRemovableView> createState() => _TagRemovableViewState();
}

class _TagRemovableViewState extends State<TagRemovableView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TagRemovableDemo(),
        ),
      ),
    );
  }
}

class TagRemovableDemo extends StatefulWidget {
  const TagRemovableDemo({super.key});

  @override
  State<TagRemovableDemo> createState() => _TagRemovableDemoState();
}

class _TagRemovableDemoState extends State<TagRemovableDemo> {
  final List<String> _tags = ['标签1', '标签2', '标签3'];

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _tags.asMap().entries.map((entry) {
          return ETag(
            text: entry.value,
            closable: true,
            onClose: () => _removeTag(entry.key),
          );
        }).toList(),
      ),
    );
  }
}
