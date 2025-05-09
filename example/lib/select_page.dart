import 'package:flutter/material.dart';
import 'package:flutter_element/src/components/select/select.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String? _value1;
  String? _value2;
  String? _value3;
  String? _value4;
  String? _value5;
  List<String>? _value6;
  final List<SelectOption> _options = const [
    SelectOption(value: '1', label: '选项1'),
    SelectOption(value: '2', label: '选项2'),
    SelectOption(value: '3', label: '选项3'),
    SelectOption(value: '4', label: '选项4'),
    SelectOption(value: '5', label: '选项5'),
  ];

  final List<SelectOption> _optionsWithDisabled = const [
    SelectOption(value: '1', label: '选项1'),
    SelectOption(value: '2', label: '选项2', disabled: true),
    SelectOption(value: '3', label: '选项3'),
    SelectOption(value: '4', label: '选项4'),
    SelectOption(value: '5', label: '选项5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select 选择器'),
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
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value1,
                options: _options,
                placeholder: '请选择',
                onChanged: (value) => {
                  setState(() => _value1 = value),
                  print('value: $value'),
                },
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value2,
                options: _options,
                placeholder: '请选择',
                disabled: true,
                onChanged: (value) => setState(() => _value2 = value),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '可清空单选',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value3,
                options: _options,
                placeholder: '请选择',
                clearable: true,
                onChanged: (value) => setState(() => _value3 = value),
                onClear: () => setState(() => _value3 = null),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '有禁用选项',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value4,
                options: _optionsWithDisabled,
                placeholder: '请选择',
                onChanged: (value) => setState(() => _value4 = value),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '不同尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value5,
                options: _options,
                placeholder: '请选择',
                size: ESelectSize.large,
                onChanged: (value) => setState(() => _value5 = value),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value5,
                options: _options,
                placeholder: '请选择',
                size: ESelectSize.medium,
                onChanged: (value) => setState(() => _value5 = value),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value5,
                options: _options,
                placeholder: '请选择',
                size: ESelectSize.small,
                onChanged: (value) => setState(() => _value5 = value),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '自定义头部',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 240,
              child: ESelect(
                value: _value6,
                options: _options,
                multiple: true,
                placeholder: '请选择',
                size: ESelectSize.small,
                onChanged: (value) => setState(() => _value6 = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
