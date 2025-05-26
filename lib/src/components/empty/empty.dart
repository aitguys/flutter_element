import 'package:flutter/material.dart';

class EEmpty extends StatelessWidget {
  final String? description;
  final String? image;
  final double imageSize;
  final Widget? child;
  final Widget? imageWidget;

  const EEmpty({
    super.key,
    this.description,
    this.image,
    this.imageSize = 120,
    this.child,
    this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageWidget ??
              (image != null
                  ? Image.network(image!,
                      width: imageSize, height: imageSize, fit: BoxFit.contain)
                  : Icon(Icons.inbox,
                      size: imageSize, color: Colors.grey[300])),
          const SizedBox(height: 16),
          Text(
            description ?? '暂无数据',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          if (child != null) ...[
            const SizedBox(height: 16),
            child!,
          ]
        ],
      ),
    );
  }
}
