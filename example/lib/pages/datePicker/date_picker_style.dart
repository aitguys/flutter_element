import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerStylePreview extends StatelessWidget {
  const DatePickerStylePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_style.dart'),
      title: '样式设置',
    );
  }
}

class DatePickerStyleView extends StatelessWidget {
  const DatePickerStyleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _viewerContent(),
        ),
      ),
    );
  }
}

Widget _viewerContent() {
  return Wrap(
    spacing: 20,
    runSpacing: 20,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: EDatePicker(
              size: ESizeItem.small,
              placeholder: '小尺寸',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              size: ESizeItem.medium,
              placeholder: '中尺寸',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              size: ESizeItem.large,
              placeholder: '大尺寸',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: EDatePicker(
              colorType: EColorType.warning,
              placeholder: '警告色',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              customColor: Colors.red,
              placeholder: '自定义颜色',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 240,
            child: EDatePicker(
              defaultColor: Colors.red,
              placeholder: '默认颜色',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: EDatePicker(
              customHeight: 40,
              customFontSize: 16,
              customBorderRadius: 10,
              placeholder: '自定义尺寸',
              onSelect: (date) {
                debugPrint('onSelect 触发： Selected date: $date');
              },
            ),
          ),
        ],
      ),
    ],
  );
}
