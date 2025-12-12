import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';
import 'package:logger/logger.dart';

class CheckboxSelectAllPreview extends StatelessWidget {
  const CheckboxSelectAllPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('checkbox_page', 'checkbox_select_all.dart'),
      title: '全选',
    );
  }
}

class CheckboxSelectAllView extends StatefulWidget {
  const CheckboxSelectAllView({super.key});

  @override
  State<CheckboxSelectAllView> createState() => _CheckboxSelectAllViewState();
}

class _CheckboxSelectAllViewState extends State<CheckboxSelectAllView> {
  List<String> valuesAll = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ECheckbox(
                label: 'Check All',
                value: valuesAll.length == 3,
                onChange: (value) {
                  setState(() {
                    valuesAll = value ? ['option1', 'option2', 'option3'] : [];
                  });
                },
              ),
              ECheckboxGroup(
                value: valuesAll,
                onChange: (values) {
                  setState(() {
                    valuesAll = List<String>.from(values);
                  });
                  Logger().d('Selected values: $values');
                },
                children: const [
                  ECheckbox(label: 'option1'),
                  ECheckbox(label: 'option2'),
                  ECheckbox(label: 'option3'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return const _CheckboxSelectAllDemo();
}

class _CheckboxSelectAllDemo extends StatefulWidget {
  const _CheckboxSelectAllDemo();

  @override
  State<_CheckboxSelectAllDemo> createState() => _CheckboxSelectAllDemoState();
}

class _CheckboxSelectAllDemoState extends State<_CheckboxSelectAllDemo> {
  List<String> valuesAll = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ECheckbox(
          label: 'this is a long label text that should wrap to multiple lines.'
          'No one’s born being good at all things. You become good at things through hard work.'
          'You’re not a varsity athlete the first time you play a new sport. You don’t hit every note the first time you sing a song.'
          'You’ve got to practice. The same principle applies to your schoolwork.',
          value: valuesAll.length == 3,
          labelWrap: true,
          onChange: (value) {
            setState(() {
              valuesAll = value ? ['option1', 'option2', 'option3'] : [];
            });
          },
        ),
        ECheckbox(
          label: 'Check All',
          value: valuesAll.length == 3,
          onChange: (value) {
            setState(() {
              valuesAll = value ? ['option1', 'option2', 'option3'] : [];
            });
          },
        ),
        ECheckboxGroup(
          value: valuesAll,
          onChange: (values) {
            setState(() {
              valuesAll = List<String>.from(values);
            });
            Logger().d('Selected values: $values');
          },
          children: const [
            ECheckbox(label: 'option1'),
            ECheckbox(label: 'option2'),
            ECheckbox(label: 'option3'),
          ],
        ),
      ],
    );
  }
}
