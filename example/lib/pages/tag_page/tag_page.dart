import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final List<String> _tags = ['标签1', '标签2', '标签3'];

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag 标签'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础用法',
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ETag(text: '标签一'),
                ETag(text: '标签二', type: ETagType.success),
                ETag(text: '标签三', type: ETagType.info),
                ETag(text: '标签四', type: ETagType.warning),
                ETag(text: '标签五', type: ETagType.danger),
              ],
            ),
          ),
          _buildSection(
            title: '可移除标签',
            child: Wrap(
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
          ),
          _buildSection(
            title: '不同尺寸',
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ETag(text: '大型标签', size: ETagSize.large),
                ETag(text: '默认标签'),
                ETag(text: '小型标签', size: ETagSize.small),
              ],
            ),
          ),
          _buildSection(
            title: '主题',
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ETag(text: '默认标签'),
                ETag(text: '圆角标签', round: true),
                ETag(text: '标记标签', type: ETagType.primary, hit: true),
              ],
            ),
          ),
          _buildSection(
            title: '自定义颜色',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const ETag(
                  text: '自定义颜色',
                  color: Colors.white,
                  backgroundColor: Colors.purple,
                ),
                ETag(
                  text: '自定义边框',
                  color: Colors.purple,
                  backgroundColor: Colors.purple.withValues(alpha: 0.1),
                  hit: true,
                ),
              ],
            ),
          ),
          _buildSection(
            title: '带图标',
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ETag(
                  text: '标签',
                  icon: Icon(Icons.check_circle),
                  type: ETagType.success,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.info),
                  type: ETagType.info,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.warning),
                  type: ETagType.warning,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.error),
                  type: ETagType.danger,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child,
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }
}
