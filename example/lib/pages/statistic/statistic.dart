import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistic 统计数值'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '基础用法',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: FlStatistic(
                    title: '访问量',
                    value: 12345,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FlStatistic(
                    title: '评论数',
                    value: 8848,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '数值动画',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: FlStatistic(
                    title: '动画效果',
                    value: 50000,
                    animation: true,
                    animationDuration: Duration(seconds: 2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '前缀后缀',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: FlStatistic(
                    title: '价格',
                    value: 568.9,
                    prefix: '¥',
                    precision: 2,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FlStatistic(
                    title: '变化率',
                    value: 6.7,
                    precision: 2,
                    suffix: '%',
                    prefixIcon: Icon(
                      Icons.arrow_upward,
                      color: Colors.green,
                      size: 16,
                    ),
                    valueColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '倒计时',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FlCountdown(
                    title: '活动倒计时',
                    value: DateTime.now().add(const Duration(days: 1)),
                    format: 'HH:mm:ss',
                    onFinish: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('倒计时结束！')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FlCountdown(
                    title: '距离新年',
                    value: DateTime(DateTime.now().year + 1),
                    format: 'DD 天 HH:mm:ss',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '自定义样式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: FlStatistic(
                    title: '自定义',
                    value: 9999,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    valueStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    suffix: '次',
                    suffixStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
