import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ButtonLoadingPreview extends StatelessWidget {
  const ButtonLoadingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code:
          'https://aitmed-public.oss-cn-hangzhou.aliyuncs.com/button_loading.dart',
      title: '加载状态按钮',
    );
  }
}

class ButtonLoadingView extends StatelessWidget {
  const ButtonLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Wrap(
    spacing: 8,
    runSpacing: 16,
    children: [
      const EButton(
        text: 'Primary Button',
        type: EColorType.primary,
        loading: true,
      ),
      EButton(
        text: 'autoLoading',
        type: EColorType.primary,
        autoLoading: true,
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
      _LoadingButtonDemo()
    ],
  );
}

class _LoadingButtonDemo extends StatefulWidget {
  @override
  _LoadingButtonDemoState createState() => _LoadingButtonDemoState();
}

class _LoadingButtonDemoState extends State<_LoadingButtonDemo> {
  bool isLoading = false;

  void _handlePress() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 16,
      children: [
        EButton(
          text: '手动实现加载',
          type: EColorType.primary,
          loading: isLoading,
          onPressed: _handlePress,
        ),
      ],
    );
  }
}
