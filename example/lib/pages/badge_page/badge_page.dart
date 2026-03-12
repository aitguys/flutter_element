import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badge 徽标'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础用法',
            subtitle: '依附在子组件角落的徽标，可显示数字或文案。',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                EBadge(
                  value: 12,
                  child: _buildDemoChild(Icons.notifications_outlined, '消息'),
                ),
                EBadge(
                  value: 3,
                  child: _buildDemoChild(Icons.shopping_cart_outlined, '购物车'),
                ),
                EBadge(
                  value: 'New',
                  child: _buildDemoChild(Icons.mail_outline, '邮件'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '小圆点',
            subtitle: '通过 isDot 显示小圆点徽标。',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                EBadge(
                  isDot: true,
                  child: _buildDemoChild(Icons.notifications_outlined, '消息'),
                ),
                EBadge(
                  isDot: true,
                  type: 'success',
                  child: _buildDemoChild(Icons.check_circle_outline, '已完成'),
                ),
                EBadge(
                  isDot: true,
                  type: 'danger',
                  child: _buildDemoChild(Icons.mail_outline, '未读'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '不同类型',
            subtitle: '通过 type 设置 primary / success / warning / danger / info。',
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                EBadge(value: 1, type: 'primary', child: _buildIconChild(Icons.add)),
                EBadge(value: 2, type: 'success', child: _buildIconChild(Icons.check)),
                EBadge(value: 3, type: 'warning', child: _buildIconChild(Icons.warning_amber)),
                EBadge(value: 4, type: 'danger', child: _buildIconChild(Icons.error_outline)),
                EBadge(value: 5, type: 'info', child: _buildIconChild(Icons.info_outline)),
              ],
            ),
          ),
          _buildSection(
            title: '最大值',
            subtitle: '超过 max 时显示为 max+，默认 99。',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                EBadge(
                  value: 99,
                  max: 99,
                  child: _buildDemoChild(Icons.notifications_outlined, '99'),
                ),
                EBadge(
                  value: 100,
                  max: 99,
                  child: _buildDemoChild(Icons.notifications_outlined, '99+'),
                ),
                EBadge(
                  value: 200,
                  max: 99,
                  child: _buildDemoChild(Icons.notifications_outlined, '99+'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '不显示零',
            subtitle: 'showZero 为 false 时，value 为 0 不显示徽标。',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                EBadge(
                  value: 0,
                  showZero: true,
                  child: _buildDemoChild(Icons.notifications_outlined, 'showZero: true'),
                ),
                EBadge(
                  value: 0,
                  showZero: false,
                  child: _buildDemoChild(Icons.notifications_outlined, 'showZero: false'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '自定义样式',
            subtitle: '自定义颜色、文字样式和徽标装饰。',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                EBadge(
                  value: 'Hot',
                  color: Colors.orange,
                  child: _buildDemoChild(Icons.local_fire_department, '热门'),
                ),
                EBadge(
                  value: 'New',
                  color: Colors.purple,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  badgeStyle: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildDemoChild(Icons.fiber_new, '新品'),
                ),
              ],
            ),
          ),
          _buildSection(
            title: '独立展示',
            subtitle: '不包裹子组件时，徽标可单独展示。',
            child: const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                EBadge(value: 1),
                EBadge(value: 'New'),
                EBadge(value: 5, type: 'success'),
                EBadge(isDot: true, type: 'danger'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
        child,
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildDemoChild(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildIconChild(IconData icon) {
    return Icon(icon, size: 28);
  }
}
