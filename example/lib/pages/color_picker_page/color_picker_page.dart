import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color _color = Colors.green;
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
              pickerColor: _color,
              onColorChanged: (color) {
                setState(() => _color = color);
              },
            ),
            const SizedBox(height: 32),
            const Text('With Alpha Channel:'),
            const SizedBox(height: 16),
            EColorPicker(
              pickerColor: _colorWithAlpha,
              showAlpha: true,
              onColorChanged: (color) {
                print('color change1: $color');
                setState(() => _colorWithAlpha = color);
              },
            ),
            const SizedBox(height: 32),
            const Text('With Predefined Colors:'),
            const SizedBox(height: 16),
            EColorPicker(
              onColorChanged: (color) {
                print('onColorChanged: $color');
                print('color: $_color');
              },
              onConfirm: (color) {
                print('color confirm: $color');
                print('color: $_color');
              },
              onCancel: () {
                print('color cancel');
                print('color: $_color');
              },
              pickerColor: _color,
              showAlpha: true,
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
            ),
            const SizedBox(height: 32),
            const Text('Different Sizes:'),
            const SizedBox(height: 16),
            Row(
              children: [
                EColorPicker(
                  pickerColor: _color,
                  size: 'large',
                  onColorChanged: (color) {
                    setState(() => _color = color);
                  },
                ),
                const SizedBox(width: 16),
                EColorPicker(
                  pickerColor: _color,
                  size: 'middle',
                  onColorChanged: (color) {
                    setState(() => _color = color);
                  },
                ),
                const SizedBox(width: 16),
                EColorPicker(
                  pickerColor: _color,
                  size: 'small',
                  onColorChanged: (color) {
                    setState(() => _color = color);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Disabled:'),
            const SizedBox(height: 16),
            EColorPicker(
              pickerColor: _color,
              disabled: true,
              onColorChanged: (color) {
                setState(() => _color = color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
