import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert 警告'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EAlert(
              title: '默认提示的文案',
              type: EAlertType.info,
              closable: true,
              showIcon: true,
            ),
            const SizedBox(height: 16),
            const EAlert(
              title: '成功提示的文案',
              type: EAlertType.success,
              showIcon: true,
            ),
            const SizedBox(height: 16),
            const EAlert(
              title: '警告提示的文案',
              type: EAlertType.warning,
              showIcon: true,
            ),
            const SizedBox(height: 16),
            const EAlert(
              title: '错误提示的文案',
              type: EAlertType.error,
              showIcon: true,
            ),
            const SizedBox(height: 32),
            const Text('带有辅助性文字介绍',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EAlert(
              title: '带辅助性文字介绍',
              description:
                  '这是一句绕口令：黑灰化肥会挥发发灰黑化肥挥发；灰黑化肥会挥发发黑灰化肥发挥。 黑灰化肥会挥发发灰黑化肥黑灰挥发化为灰……',
              type: EAlertType.success,
              showIcon: true,
            ),
            const SizedBox(height: 32),
            const Text('居中对齐',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EAlert(
              title: '居中对齐的文案',
              description: '这是一句绕口令：黑灰化肥会挥发发灰黑化肥挥发；灰黑化肥会挥发发黑灰化肥发挥。',
              type: EAlertType.info,
              center: true,
              showIcon: true,
            ),
            const SizedBox(height: 32),
            const Text('函数调用方式',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showAlert(
                      context: context,
                      title: '成功提示',
                      description: '这是一条成功消息提示',
                      type: EAlertType.success,
                      showIcon: true,
                      autoCloseDuration: const Duration(seconds: 3),
                    );
                  },
                  child: const Text('显示成功提示'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showAlert(
                      context: context,
                      title: '错误提示',
                      description: '这是一条错误消息提示',
                      type: EAlertType.error,
                      showIcon: true,
                      autoCloseDuration: const Duration(seconds: 3),
                    );
                  },
                  child: const Text('显示错误提示'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
