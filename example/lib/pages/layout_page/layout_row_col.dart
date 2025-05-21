import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class LayoutRowColPage extends StatelessWidget {
  const LayoutRowColPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row 和 Col 栅格'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '基础栅格',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.row(
              children: [
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.blue[100],
                    child: Center(child: Text('col-12')),
                  ),
                  span: 12,
                  padding: EdgeInsets.all(5),
                ),
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.blue[200],
                    child: Center(child: Text('col-12')),
                  ),
                  span: 12,
                  padding: EdgeInsets.all(5),
                ),
              ],
              gutter: 10,
            ),
            SizedBox(height: 20),
            Text(
              '栅格间隔',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.row(
              children: [
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.green[100],
                    child: Center(child: Text('col-8')),
                  ),
                  span: 8,
                  padding: EdgeInsets.all(5),
                ),
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.green[200],
                    child: Center(child: Text('col-8')),
                  ),
                  span: 8,
                  padding: EdgeInsets.all(5),
                ),
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.green[300],
                    child: Center(child: Text('col-8')),
                  ),
                  span: 8,
                  padding: EdgeInsets.all(5),
                ),
              ],
              gutter: 20,
            ),
            SizedBox(height: 20),
            Text(
              '栅格偏移',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.row(
              children: [
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.orange[100],
                    child: Center(child: Text('col-6')),
                  ),
                  span: 6,
                  padding: EdgeInsets.all(5),
                ),
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.orange[200],
                    child: Center(child: Text('col-6 offset-6')),
                  ),
                  span: 6,
                  offset: 6,
                  padding: EdgeInsets.all(5),
                ),
              ],
              gutter: 10,
            ),
            SizedBox(height: 20),
            Text(
              '栅格排序',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FlutterElementLayout.row(
              children: [
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.purple[100],
                    child: Center(child: Text('col-6 push-6')),
                  ),
                  span: 6,
                  push: 6,
                  padding: EdgeInsets.all(5),
                ),
                FlutterElementLayout.col(
                  child: Container(
                    height: 100,
                    color: Colors.purple[200],
                    child: Center(child: Text('col-6 pull-6')),
                  ),
                  span: 6,
                  pull: 6,
                  padding: EdgeInsets.all(5),
                ),
              ],
              gutter: 10,
            ),
          ],
        ),
      ),
    );
  }
}
