import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/empty/empty.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empty 空状态')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            EEmpty(),
            const SizedBox(height: 32),
            const Text('自定义描述'),
            const SizedBox(height: 16),
            EEmpty(description: '没有找到相关数据'),
            const SizedBox(height: 32),
            const Text('自定义图片'),
            const SizedBox(height: 16),
            EEmpty(
              image: 'https://element-plus.org/images/empty-image.png',
              description: '暂无内容',
            ),
            const SizedBox(height: 32),
            const Text('自定义插槽'),
            const SizedBox(height: 16),
            EEmpty(
              description: '没有数据',
              child: EButton(
                type: EButtonType.Primary,
                text: '重新加载',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
