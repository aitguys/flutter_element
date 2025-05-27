import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline 时间线'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础用法',
            child: const ETimeline(
              items: [
                ETimelineItem(
                  content: Text('活动按期开始'),
                ),
                ETimelineItem(
                  content: Text('通过审核'),
                ),
                ETimelineItem(
                  content: Text('活动按期结束'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '带时间戳',
            child: const ETimeline(
              items: [
                ETimelineItem(
                  timestamp: '2024-03-20',
                  content: Text('创建成功'),
                ),
                ETimelineItem(
                  timestamp: '2024-03-21',
                  content: Text('通过审核'),
                ),
                ETimelineItem(
                  timestamp: '2024-03-22',
                  content: Text('活动按期结束'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '时间戳位置',
            child: const ETimeline(
              items: [
                ETimelineItem(
                  timestamp: '2024-03-20',
                  content: Text('创建成功'),
                ),
                ETimelineItem(
                  timestamp: '2024-03-21',
                  content: Text('通过审核'),
                ),
                ETimelineItem(
                  timestamp: '2024-03-22',
                  content: Text('活动按期结束'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '不同类型',
            child: const ETimeline(
              items: [
                ETimelineItem(
                  type: ETimelineItemType.primary,
                  content: Text('主要类型'),
                ),
                ETimelineItem(
                  type: ETimelineItemType.success,
                  content: Text('成功类型'),
                ),
                ETimelineItem(
                  type: ETimelineItemType.warning,
                  content: Text('警告类型'),
                ),
                ETimelineItem(
                  type: ETimelineItemType.danger,
                  content: Text('危险类型'),
                ),
                ETimelineItem(
                  type: ETimelineItemType.info,
                  content: Text('信息类型'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '自定义节点',
            child: ETimeline(
              items: [
                ETimelineItem(
                  dot: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  content: const Text('自定义成功图标'),
                ),
                const ETimelineItem(
                  dot: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 24,
                  ),
                  content: Text('自定义警告图标'),
                ),
                ETimelineItem(
                  dot: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  content: const Text('自定义信息图标'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '空心圆点',
            child: const ETimeline(
              items: [
                ETimelineItem(
                  hollow: true,
                  type: ETimelineItemType.primary,
                  content: Text('空心圆点'),
                ),
                ETimelineItem(
                  hollow: true,
                  type: ETimelineItemType.success,
                  content: Text('空心圆点'),
                ),
                ETimelineItem(
                  hollow: true,
                  type: ETimelineItemType.warning,
                  content: Text('空心圆点'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '自定义内容',
            child: ETimeline(
              items: [
                ETimelineItem(
                  content: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '自定义卡片内容',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '这是一段自定义的卡片内容描述文字。',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ETimelineItem(
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('自定义背景内容'),
                  ),
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
