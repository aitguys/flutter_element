import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({Key? key}) : super(key: key);

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton 骨架屏'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础用法',
            child: Column(
              children: [
                ESkeleton(height: 40),
                SizedBox(height: 12),
                ESkeleton(height: 40),
                SizedBox(height: 12),
                ESkeleton(height: 40),
              ],
            ),
          ),
          _buildSection(
            title: '动画效果',
            child: ESkeleton(
              height: 40,
              animated: true,
              active: true,
            ),
          ),
          _buildSection(
            title: '带头像的卡片',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ESkeletonItem(
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.circular(40),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ESkeleton(height: 20, width: 200),
                      SizedBox(height: 12),
                      ESkeleton(height: 16),
                      SizedBox(height: 8),
                      ESkeleton(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '加载状态切换',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ESkeleton(
                  loading: _loading,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '这是一个标题',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '这是一段内容描述文字，当加载完成时才会显示。这里可以放置任意的实际内容。',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _loading = !_loading;
                    });
                  },
                  child: Text(_loading ? '显示内容' : '显示骨架屏'),
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
