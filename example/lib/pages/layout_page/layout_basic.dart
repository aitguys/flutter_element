import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class LayoutBasicPage extends StatelessWidget {
  const LayoutBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础布局'),
      ),
      body: FlutterElementLayout.container(
        direction: false,
        child: Row(
          children: [
            FlutterElementLayout.aside(
              child: Center(
                child: Text('Aside'),
              ),
              backgroundColor: Colors.grey[200],
              width: 200,
            ),
            Expanded(
              child: Column(
                children: [
                  FlutterElementLayout.header(
                    child: Center(
                      child: Text(
                        'Header',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    backgroundColor: Colors.blue,
                    height: 60,
                  ),
                  Expanded(
                    child: FlutterElementLayout.container(
                      direction: true,
                      child: Row(
                        children: [
                          Expanded(
                            child: FlutterElementLayout.main(
                              child: Center(
                                child: Text('Main Content'),
                              ),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlutterElementLayout.footer(
                    child: Center(
                      child: Text(
                        'Footer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    backgroundColor: Colors.blue,
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
