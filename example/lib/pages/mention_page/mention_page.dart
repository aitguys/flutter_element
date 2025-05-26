import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:logger/logger.dart';

class MentionPage extends StatefulWidget {
  const MentionPage({super.key});

  @override
  State<MentionPage> createState() => _MentionPageState();
}

class _MentionPageState extends State<MentionPage> {
  bool _loading = false;
  final List<MentionOption> _options = [
    const MentionOption(value: 'Fuphoenixes', label: 'Fuphoenixes'),
    const MentionOption(value: 'kooriookami', label: 'kooriookami'),
    const MentionOption(value: 'Jeremy', label: 'Jeremy'),
    const MentionOption(value: 'btea', label: 'btea'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMention 测试')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              placeholder: '请输入 @ 触发提及',
              whole: true,
              onSearch: (query) {
                Logger().d('搜索: $query');
              },
              onSelect: (option) {
                Logger().d('选择: ${option.value}');
              },
            ),
            const SizedBox(height: 32),
            const Text('自定义触发前缀'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              triggerPrefixes: ['@', '#'],
              placeholder: '输入 @ 提及用户，输入 # 提及标签',
            ),
            const SizedBox(height: 32),
            const Text('加载状态'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              loading: _loading,
              placeholder: '请输入 @ 触发提及',
              onSearch: (query) {
                setState(() => _loading = true);
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() => _loading = false);
                });
              },
            ),
            const SizedBox(height: 32),
            const Text('禁用状态'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              disabled: true,
              placeholder: '禁用状态',
            ),
            const SizedBox(height: 32),
            const Text('只读状态'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              readOnly: true,
              placeholder: '只读状态',
            ),
            const SizedBox(height: 32),
            const Text('自定义图标'),
            const SizedBox(height: 16),
            EMention(
              options: _options,
              whole: true,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.help_outline),
              placeholder: '自定义图标',
            ),
          ],
        ),
      ),
    );
  }
}
