import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class WatermarkPage extends StatelessWidget {
  const WatermarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watermark 水印'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('基础用法'),
          const SizedBox(height: 16),
          Watermark(
            content: 'Flutter Element',
            child: Container(
              height: 200,
              color: Colors.white,
              child: const Center(
                child: Text('基础水印示例'),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('自定义配置'),
          const SizedBox(height: 16),
          Watermark(
            content: 'Confidential',
            rotate: -30,
            fontSize: 20,
            color: Colors.red,
            opacity: 0.1,
            gap: 120,
            child: Container(
              height: 200,
              color: Colors.white,
              child: const Center(
                child: Text('自定义水印示例'),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('水印在内容之上'),
          const SizedBox(height: 16),
          Watermark(
            content: 'Top Layer',
            zIndex: true,
            child: Container(
              height: 200,
              color: Colors.white,
              child: const Center(
                child: Text('水印在上层示例'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
