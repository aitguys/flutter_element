import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
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
                ETag(text: '标签二', type: EColorType.success),
                ETag(text: '标签三', type: EColorType.info),
                ETag(text: '标签四', type: EColorType.warning),
                ETag(text: '标签五', type: EColorType.danger),
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
                ETag(text: '大型标签', size: ESizeItem.large),
                ETag(text: '默认标签'),
                ETag(text: '小型标签', size: ESizeItem.small),
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
                ETag(text: '圆角标签', isRound: true),
                ETag(text: '标记标签', type: EColorType.primary, isCircle: true),
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
                  type: EColorType.success,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.info),
                  type: EColorType.info,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.warning),
                  type: EColorType.warning,
                ),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.error),
                  type: EColorType.danger,
                ),
              ],
            ),
          ),
          _buildSection(
            title: '自定义内容',
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ETag(text: '标签', child: Text('自定义内容')),
                ETag(
                  text: '标签',
                  icon: Icon(Icons.check_circle),
                  type: EColorType.success,
                  child: Text('自定义内容'),
                ),
              ],
            ),
          ),
          // events
          _buildSection(
            title: '事件',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ETag(
                  text: '标签',
                  icon: const Icon(Icons.check_circle),
                  type: EColorType.success,
                  closable: true,
                  onPressed: () {
                    Loglevel.d('onPressed');
                  },
                  onLongPressed: () {
                    Loglevel.d('onLongPressed');
                  },
                  onClose: () {
                    Loglevel.d('onClose');
                  },
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
