import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
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
              '自定义尺寸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              size: ESizeItem.large,
              onChanged: (value) => setState(() => _value5 = value),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              size: ESizeItem.medium,
              onChanged: (value) => setState(() => _value5 = value),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              size: ESizeItem.small,
              onChanged: (value) => setState(() => _value5 = value),
            ),
            const SizedBox(height: 20),
            const Text(
                'customHeight 自定义高度， customHeight 和 size 同时设置时，customHeight 优先级更高'),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              customHeight: 60,
              onChanged: (value) => setState(() => _value5 = value),
            ),
            // customfontSize
            const Text(
                'customFontSize 自定义字体大小， customFontSize 和 size 同时设置时，customFontSize 优先级更高'),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              size: ESizeItem.small,
              customFontSize: 20,
              onChanged: (value) => setState(() => _value5 = value),
            ),
            // customBorderRadius
            const Text(
                'customBorderRadius 自定义圆角， customBorderRadius 和 size 同时设置时，customBorderRadius 优先级更高'),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              customBorderRadius: 10,
              onChanged: (value) => setState(() {
                _value5 = value;
                Loglevel.d('value: $value');
              }),
            ),
            // 单选和多选
            const SizedBox(height: 20),
            const Text(
              '单选和多选',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('多选时，value 为 List<String>，单选时，value 为 String'),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择 - 单选',
              onChanged: (value) => setState(() {
                _value5 = value;
                Loglevel.d('value: $value');
              }),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value6,
              options: _options,
              placeholder: '请选择 - 多选',
              multiple: true,
              onChanged: (value) => setState(() {
                _value6 = value;
                Loglevel.d('value: $value');
              }),
            ),

            const SizedBox(height: 40),
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value2,
              options: _options,
              placeholder: '请选择',
              disabled: true,
              onChanged: (value) => setState(() => _value2 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '可清空',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value3,
              options: _options,
              placeholder: '请选择 - 可清空 单选',
              clearable: true,
              onChanged: (value) => setState(() {
                _value3 = value;
                Loglevel.d('触发onchange: $value');
              }),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value6,
              options: _options,
              placeholder: '请选择 - 可清空 多选',
              clearable: true,
              multiple: true,
              onChanged: (value) => setState(() => _value6 = value),
            ),
            const SizedBox(height: 40),
            // prefix , sufix , prepend , append
            const Text(
              'prefix , sufix , prepend , append。 suffix 可以用来替换默认的箭头图标',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value5,
              options: _options,
              placeholder: '请选择',
              prefix: const Icon(Icons.search),
              suffix: const Icon(Icons.arrow_drop_down),
              prepend: const Icon(Icons.search),
              append: const Icon(Icons.arrow_drop_down),
              onChanged: (value) => setState(() => _value5 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '有禁用选项',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ESelect(
              value: _value4,
              options: _optionsWithDisabled,
              placeholder: '请选择',
              onChanged: (value) => setState(() => _value4 = value),
            ),
            const SizedBox(height: 40),
            const Text(
              '自定义头部',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ESelect(
              value: _value6,
              options: _options,
              multiple: true,
              placeholder: '请选择',
              size: ESizeItem.small,
              onChanged: (value) => setState(() => _value6 = value),
              header: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User Name'),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
