import 'package:flutter/material.dart';
import 'package:flutter_element/src/components/radio/radio.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  String _radio1 = '1';
  String _radio2 = '1';
  String _radio3 = '1';
  String _radio4 = '1';
  String _radio5 = '1';
  String _radio6 = '1';
  String _radio7 = '1';
  String _radio8 = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio 单选框'),
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
            ERadioGroup(
              value: _radio1,
              onChanged: (value) => setState(() => _radio1 = value),
              children: [
                ERadio(value: '1', label: '选项1'),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio2,
              onChanged: (value) => setState(() => _radio2 = value),
              children: [
                ERadio(value: '1', label: '选项1', disabled: true),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '单选框组',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio3,
              onChanged: (value) => setState(() => _radio3 = value),
              children: [
                ERadio(value: '1', label: '选项A'),
                ERadio(value: '2', label: '选项B'),
                ERadio(value: '3', label: '选项C'),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '不同尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio4,
              size: ERadioSize.large,
              onChanged: (value) => setState(() => _radio4 = value),
              children: [
                ERadio(value: '1', label: '选项1'),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio5,
              size: ERadioSize.medium,
              onChanged: (value) => setState(() => _radio5 = value),
              children: [
                ERadio(value: '1', label: '选项1'),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio6,
              size: ERadioSize.small,
              onChanged: (value) => setState(() => _radio6 = value),
              children: [
                ERadio(value: '1', label: '选项1'),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '带边框',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio7,
              onChanged: (value) => setState(() => _radio7 = value),
              children: [
                ERadio(value: '1', label: '选项1', border: true),
                ERadio(value: '2', label: '选项2', border: true),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ERadioGroup(
              value: _radio8,
              disabled: true,
              onChanged: (value) => setState(() => _radio8 = value),
              children: [
                ERadio(value: '1', label: '选项1'),
                ERadio(value: '2', label: '选项2'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
