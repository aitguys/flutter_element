import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress 进度条')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Text('默认样式'),
            const EProgress(
              percentage: 30,
            ),
            const SizedBox(height: 16),
            const Text('内置状态'),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 40,
              colorType: EColorType.danger,
            ),
            const SizedBox(height: 16),
            const Text('自定义内容，percentage 作为参数'),
            const SizedBox(height: 16),
            EProgress(
              percentage: 30,
              customBuilder: (percentage) => Text(
                '您的进度已经有 ${percentage.toStringAsFixed(0)}% 了',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Text('不显示文本'),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              showText: false,
            ),
            // 进度条内显示百分比标识
            const SizedBox(height: 16),
            const Text('进度条内显示百分比标识',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // Progress 组件可通过 stroke-width 属性更改进度条的高度，并可通过 text-inside 属性来改变进度条内部的文字。
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              strokeWidth: 20,
              textInside: true,
            ),
            const SizedBox(height: 16),
            const Text('自定义进度条的颜色',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              color: Colors.orange,
            ),
            const Text('环形进度条',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text(
                'Progress 组件可通过 type 属性来指定使用环形进度条，在环形进度条中，还可以通过 width 属性来设置其大小。'),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              type: EProgressType.circle,
              width: 100,
            ),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              type: EProgressType.circle,
              width: 100,
              colorType: EColorType.success,
            ),
            const SizedBox(height: 16),
            EProgress(
              percentage: 30,
              type: EProgressType.circle,
              width: 100,
              customBuilder: (percentage) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Progressing...',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // 动画进度条
            const SizedBox(height: 16),
            const Text('动画进度条',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              indeterminate: true,
              duration: 2,
            ),
            const SizedBox(height: 16),
            const EProgress(
              type: EProgressType.circle,
              percentage: 30,
              width: 100,
              indeterminate: true,
              duration: 2,
            ),
//             条纹进度条​
// 通过设置 striped 属性获取条纹进度条。 也可以使用 striped-flow 属性来使条纹流动起来。 使用duration 属性来控制条纹流动的速度。
            const SizedBox(height: 16),
            const Text('条纹进度条',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 30,
              striped: true,
              duration: 2,
            ),
            const SizedBox(height: 16),
            const EProgress(
              percentage: 100,
              striped: true,
              stripedFlow: true,
              color: Colors.orange,
              duration: 1,
            ),
          ],
        ),
      ),
    );
  }
}
