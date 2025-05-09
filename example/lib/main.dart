// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';
import 'button_page.dart';
import 'link_page.dart';
import 'scrollbar_page.dart';
import 'autocomplete_page.dart';
import 'checkbox_page.dart';
import 'color_picker_page.dart';
import 'date_picker.dart';
import 'time_picker_page.dart';
import 'input_page.dart';
import 'input_number_page.dart';
import 'input_tag.dart';

void main() {
  runApp(const ElementXApp());
}

class ElementXApp extends StatelessWidget {
  const ElementXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Element'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EButton(
              text: 'Button Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ButtonPage()),
                );
              },
            ),
            EButton(
              text: 'Link Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LinkPage()),
                );
              },
            ),
            EButton(
              text: 'Scrollbar Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScrollbarPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Autocomplete Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AutocompletePage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Checkbox Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CheckboxPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Color Picker Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ColorPickerPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Date Picker Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DatePickerPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Time Picker Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TimePickerPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Input Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InputPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Input Number Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InputNumberPage(),
                  ),
                );
              },
            ),
            EButton(
              text: 'Input Tag Examples',
              type: EButtonType.Primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InputTagPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
