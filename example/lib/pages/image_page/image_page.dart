import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element_plus.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image 图片')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            const EImage(
              src: 'https://element-plus.org/images/element-plus-logo.svg',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 32),
            const Text('不同 fit'),
            const SizedBox(height: 16),
            const Row(
              children: [
                EImage(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 16),
                EImage(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 16),
                EImage(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                EImage(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 16),
                EImage(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('圆角图片'),
            const SizedBox(height: 16),
            const EImage(
              src: 'https://element-plus.org/images/element-plus-logo.svg',
              width: 120,
              height: 120,
              borderRadius: 16,
            ),
            const SizedBox(height: 32),
            const Text('占位/加载失败'),
            const SizedBox(height: 16),
            Row(
              children: [
                EImage(
                  src: 'https://not-exist-url.png',
                  width: 80,
                  height: 80,
                  placeholder: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Center(child: Text('加载中')),
                  ),
                ),
                const SizedBox(width: 16),
                EImage(
                  src: 'https://not-exist-url.png',
                  width: 80,
                  height: 80,
                  errorWidget: Container(
                    width: 80,
                    height: 80,
                    color: Colors.red[100],
                    child: const Center(child: Text('加载失败')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('图片预览'),
            const SizedBox(height: 16),
            const EImage(
              src:
                  'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg',
              width: 120,
              height: 120,
              preview: true,
            ),
          ],
        ),
      ),
    );
  }
}
