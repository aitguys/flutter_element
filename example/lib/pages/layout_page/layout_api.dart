import 'package:flutter/material.dart';

class LayoutApiPage extends StatelessWidget {
  const LayoutApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout API'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildApiSection(
              'Container 容器',
              [
                _buildApiItem('direction', 'bool?', '布局方向，true 为水平，false 为垂直'),
                _buildApiItem('directionStr', 'String?',
                    '布局方向字符串，\'horizontal\' 或 \'vertical\''),
                _buildApiItem('height', 'double?', '容器高度'),
                _buildApiItem('width', 'double?', '容器宽度'),
                _buildApiItem('backgroundColor', 'Color?', '背景颜色'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
                _buildApiItem('margin', 'EdgeInsetsGeometry?', '外边距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Header 头部',
              [
                _buildApiItem('height', 'double?', '头部高度，默认 60'),
                _buildApiItem('backgroundColor', 'Color?', '背景颜色'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Aside 侧边栏',
              [
                _buildApiItem('width', 'double?', '侧边栏宽度，默认 200'),
                _buildApiItem('backgroundColor', 'Color?', '背景颜色'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Main 主要内容区',
              [
                _buildApiItem('backgroundColor', 'Color?', '背景颜色'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Footer 底部',
              [
                _buildApiItem('height', 'double?', '底部高度，默认 60'),
                _buildApiItem('backgroundColor', 'Color?', '背景颜色'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Row 行',
              [
                _buildApiItem(
                    'mainAxisAlignment', 'MainAxisAlignment?', '主轴对齐方式'),
                _buildApiItem(
                    'crossAxisAlignment', 'CrossAxisAlignment?', '交叉轴对齐方式'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
                _buildApiItem('gutter', 'double?', '列间距'),
              ],
            ),
            SizedBox(height: 20),
            _buildApiSection(
              'Col 列',
              [
                _buildApiItem('span', 'int?', '栅格占据的列数，默认 1'),
                _buildApiItem('offset', 'int?', '栅格左侧的间隔格数'),
                _buildApiItem('push', 'int?', '栅格向右移动格数'),
                _buildApiItem('pull', 'int?', '栅格向左移动格数'),
                _buildApiItem('padding', 'EdgeInsetsGeometry?', '内边距'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...items,
      ],
    );
  }

  Widget _buildApiItem(String name, String type, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(description),
        ],
      ),
    );
  }
}
