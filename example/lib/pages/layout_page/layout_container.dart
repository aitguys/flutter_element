import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class LayoutContainerPage extends StatelessWidget {
  const LayoutContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container 容器'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '水平布局',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.container(
              direction: true,
              height: 100,
              backgroundColor: Colors.blue[100],
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('水平布局容器'),
              ),
            ),
            Text(
              '垂直布局',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.container(
              direction: false,
              height: 200,
              backgroundColor: Colors.green[100],
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('垂直布局容器'),
              ),
            ),
            Text(
              '自定义尺寸',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.container(
              direction: true,
              height: 150,
              width: 300,
              backgroundColor: Colors.orange[100],
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('自定义尺寸容器'),
              ),
            ),
            Text(
              '自定义边距',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.container(
              direction: true,
              height: 100,
              backgroundColor: Colors.purple[100],
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text('自定义边距容器'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
