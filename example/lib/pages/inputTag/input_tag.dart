import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class InputTagPage extends StatefulWidget {
  const InputTagPage({super.key});

  @override
  State<InputTagPage> createState() => _InputTagPageState();
}

class _InputTagPageState extends State<InputTagPage> {
  List<String> _value = [];

  Widget _customTagBuilder(BuildContext context, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 16,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EInputTag 测试')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('基础用法'),
              EInputTag(
                value: _value,
                trigger: EInputTagTrigger.space,
                clearable: true,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              const Text('自定义tag样式'),
              EInputTag(
                value: _value,
                trigger: EInputTagTrigger.space,
                clearable: true,
                tagBuilder: _customTagBuilder,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              const Text('自定义prefix 和 suffix'),
              EInputTag(
                value: _value,
                trigger: EInputTagTrigger.space,
                clearable: true,
                prefix: const Icon(Icons.people),
                suffix: const Icon(Icons.search),
              ),
              // max 控制最大标签数量
              const SizedBox(height: 24),
              const Text('max 控制 最大标签数量'),
              EInputTag(
                value: _value,
                trigger: EInputTagTrigger.space,
                max: 3,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // delimiter
              const SizedBox(height: 24),
              const Text('delimiter 控制 分割符'),
              EInputTag(
                value: _value,
                trigger: EInputTagTrigger.space,
                delimiter: ',',
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // trigger
              const SizedBox(height: 24),
              const Text('trigger 控制 触发事件,可以指定为enter 或 space'),
              EInputTag(
                value: _value,
                placeholder: 'enter 触发',
                trigger: EInputTagTrigger.enter,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              EInputTag(
                value: _value,
                placeholder: 'space 触发',
                trigger: EInputTagTrigger.space,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // saveOnBlur
              const SizedBox(height: 24),
              const Text('saveOnBlur 控制 是否在失去焦点时保存输入,默认是true'),
              EInputTag(
                value: _value,
                saveOnBlur: true,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              EInputTag(
                value: _value,
                saveOnBlur: false,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // clearable
              const SizedBox(height: 24),
              const Text('clearable 控制 是否显示清除按钮,默认是true'),
              EInputTag(
                value: _value,
                clearable: true,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // disabled ,readOnly
              const SizedBox(height: 24),
              const Text('disabled 和 readOnly 控制 是否禁用,默认是false'),
              EInputTag(
                value: _value,
                disabled: true,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              EInputTag(
                value: _value,
                readOnly: true,
              ),
              // size
              const SizedBox(height: 24),
              const Text('size 控制 大小,默认是medium'),
              EInputTag(
                value: _value,
                size: ESizeItem.small,
                placeholder: 'small',
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              const SizedBox(height: 24),
              EInputTag(
                value: _value,
                size: ESizeItem.large,
                placeholder: 'large',
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // customFontSize
              const SizedBox(height: 24),
              const Text(
                  'customFontSize 和 customHeight, customBorderRadius 控制 自定义 字体大小,高度,圆角'),
              EInputTag(
                value: _value,
                placeholder: 'customFontSize, customHeight',
                customFontSize: 12,
                customHeight: 20,
                customBorderRadius: 10,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),

              // customColor defaultColor
              const SizedBox(height: 24),
              const Text('customColor 和 defaultColor 控制 自定义颜色和默认颜色'),
              EInputTag(
                value: _value,
                customColor: Colors.red,
                defaultColor: Colors.blue,
                onChanged: (value) => setState(() => _value = value ?? []),
              ),
              // api
              const SizedBox(height: 24),
              const Text('api'),
              EInputTag(
                value: _value,
                placeholder: 'api',
                clearable: true,
                prefix: const Icon(Icons.people),
                suffix: const Icon(Icons.search),
                max: 3,
                onChanged: (value) => setState(() => _value = value ?? []),
                onFocus: () => Loglevel.d('onFocus'),
                onBlur: () => Loglevel.d('onBlur'),
                onAddTag: (tag, value) => Loglevel.d('onAddTag: $tag, $value'),
                onRemoveTag: (tag, value) =>
                    Loglevel.d('onRemoveTag: $tag, $value'),
                onClear: () => Loglevel.d('onClear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
