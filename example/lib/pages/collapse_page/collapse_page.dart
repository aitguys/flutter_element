import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'package:flutter_element/src/components/collapse/collapse.dart';

class CollapsePage extends StatefulWidget {
  const CollapsePage({Key? key}) : super(key: key);

  @override
  State<CollapsePage> createState() => _CollapsePageState();
}

class _CollapsePageState extends State<CollapsePage> {
  List<int> _active = [0];
  List<int> _activeAccordion = [0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collapse 折叠面板')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            ECollapse(
              panels: [
                ECollapsePanel(
                  title: const Text('面板1'),
                  child: const Text('内容1',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                ),
                ECollapsePanel(
                  title: const Text('面板2'),
                  child: const Text('内容2',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                ECollapsePanel(
                  title: const Text('面板3'),
                  child: const Text('内容3'),
                ),
              ],
              activeIndexes: _active,
              onChange: (v) => setState(() => _active = v),
            ),
            const SizedBox(height: 32),
            const Text('手风琴模式'),
            const SizedBox(height: 16),
            ECollapse(
              panels: [
                ECollapsePanel(
                  title: const Text('面板A'),
                  child: const Text('内容A'),
                ),
                ECollapsePanel(
                  title: const Text('面板B'),
                  child: const Text('内容B'),
                ),
                ECollapsePanel(
                  title: const Text('面板C'),
                  child: const Text('内容C'),
                ),
              ],
              accordion: true,
              activeIndexes: _activeAccordion,
              onChange: (v) => setState(() => _activeAccordion = v),
            ),
            const SizedBox(height: 32),
            const Text('禁用面板'),
            const SizedBox(height: 16),
            ECollapse(
              panels: [
                ECollapsePanel(
                  title: const Text('可用面板'),
                  child: const Text('内容可用'),
                ),
                ECollapsePanel(
                  title: const Text('禁用面板'),
                  child: const Text('内容禁用'),
                  disabled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
