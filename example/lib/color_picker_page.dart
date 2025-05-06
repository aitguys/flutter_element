import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color _color = Colors.red;
  Color _colorWithAlpha = Colors.blue.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Basic Usage:'),
            const SizedBox(height: 16),
            EColorPicker(
              value: _color,
              onChange: (color) {
                setState(() => _color = color);
              },
            ),
            const SizedBox(height: 32),
            const Text('With Alpha Channel:'),
            const SizedBox(height: 16),
            EColorPicker(
              value: _colorWithAlpha,
              showAlpha: true,
              onChange: (color) {
                print('color change1: $color');
                setState(() => _colorWithAlpha = color);
              },
            ),
            const SizedBox(height: 32),
            const Text('With Predefined Colors:'),
            const SizedBox(height: 16),
            EColorPicker(
              value: _color,
              predefine: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
                Colors.pink,
                Colors.teal,
              ],
              onChange: (color) {
                print('color change: $color');
                setState(() => _color = color);
              },
            ),
            const SizedBox(height: 32),
            const Text('Different Sizes:'),
            const SizedBox(height: 16),
            Row(
              children: [
                EColorPicker(
                  value: _color,
                  size: 'large',
                  onChange: (color) {
                    setState(() => _color = color);
                  },
                ),
                const SizedBox(width: 16),
                EColorPicker(
                  value: _color,
                  onChange: (color) {
                    setState(() => _color = color);
                  },
                ),
                const SizedBox(width: 16),
                EColorPicker(
                  value: _color,
                  size: 'small',
                  onChange: (color) {
                    setState(() => _color = color);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Disabled:'),
            const SizedBox(height: 16),
            EColorPicker(
              value: _color,
              disabled: true,
              onChange: (color) {
                setState(() => _color = color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
