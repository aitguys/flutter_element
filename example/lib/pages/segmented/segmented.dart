import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class SegmentedPage extends StatefulWidget {
  const SegmentedPage({super.key});

  @override
  State<SegmentedPage> createState() => _SegmentedPageState();
}

class _SegmentedPageState extends State<SegmentedPage> {
  String _selectedValue1 = 'Weekly';
  String _selectedValue2 = 'List';
  String _selectedValue3 = 'Spring';
  String _selectedValue4 = 'Option A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segmented 分段控制器'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '基础用法',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlSegmented<String>(
              options: const [
                FlSegmentedOption(label: 'Weekly', value: 'Weekly'),
                FlSegmentedOption(label: 'Monthly', value: 'Monthly'),
                FlSegmentedOption(label: 'Yearly', value: 'Yearly'),
              ],
              value: _selectedValue1,
              onChange: (value) {
                setState(() {
                  _selectedValue1 = value;
                });
              },
            ),
            const SizedBox(height: 40),
            const Text(
              '禁用选项',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlSegmented<String>(
              options: const [
                FlSegmentedOption(label: 'List', value: 'List'),
                FlSegmentedOption(
                  label: 'Kanban',
                  value: 'Kanban',
                  disabled: true,
                ),
                FlSegmentedOption(label: 'Calendar', value: 'Calendar'),
              ],
              value: _selectedValue2,
              onChange: (value) {
                setState(() {
                  _selectedValue2 = value;
                });
              },
            ),
            const SizedBox(height: 40),
            const Text(
              '带图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlSegmented<String>(
              options: const [
                FlSegmentedOption(
                  label: 'Spring',
                  value: 'Spring',
                  icon: Icon(Icons.wb_sunny),
                ),
                FlSegmentedOption(
                  label: 'Summer',
                  value: 'Summer',
                  icon: Icon(Icons.beach_access),
                ),
                FlSegmentedOption(
                  label: 'Autumn',
                  value: 'Autumn',
                  icon: Icon(Icons.forest),
                ),
                FlSegmentedOption(
                  label: 'Winter',
                  value: 'Winter',
                  icon: Icon(Icons.ac_unit),
                ),
              ],
              value: _selectedValue3,
              onChange: (value) {
                setState(() {
                  _selectedValue3 = value;
                });
              },
            ),
            const SizedBox(height: 40),
            const Text(
              '自定义样式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FlSegmented<String>(
              options: const [
                FlSegmentedOption(label: 'Option A', value: 'Option A'),
                FlSegmentedOption(label: 'Option B', value: 'Option B'),
                FlSegmentedOption(label: 'Option C', value: 'Option C'),
              ],
              value: _selectedValue4,
              onChange: (value) {
                setState(() {
                  _selectedValue4 = value;
                });
              },
              block: true,
              backgroundColor: Colors.grey[100],
              selectedBackgroundColor: Colors.blue[100],
              borderColor: Colors.blue,
              textStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
