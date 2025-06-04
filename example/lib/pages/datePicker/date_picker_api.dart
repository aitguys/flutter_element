import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';
import '../../const/index.dart';

class DatePickerApiPreview extends StatelessWidget {
  const DatePickerApiPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetPreview(
      widget: _viewerContent(),
      code: getCodeUrl('datePicker', 'date_picker_api.dart'),
      title: 'API',
    );
  }
}

class DatePickerApiView extends StatelessWidget {
  const DatePickerApiView({super.key});

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
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('EDatePicker 属性',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Text('value: String? - 当前选中的日期值'),
      Text('format: String? - 日期格式'),
      Text(
          'type: CalendarType - 日期选择器类型，可选值：date, dates, month, months, year, years'),
      Text('minDate: DateTime? - 可选的最小日期'),
      Text('maxDate: DateTime? - 可选的最大日期'),
      Text('weekDate: bool - 是否显示周视图，仅在 type 为 date 时有效'),
      Text('placeholder: String - 占位文本'),
      Text('disabled: bool - 是否禁用'),
      Text('clearable: bool - 是否可清空'),
      Text('size: ESizeItem - 尺寸大小'),
      Text('prefix: Widget? - 前缀图标'),
      Text('suffix: Widget? - 后缀图标'),
      Text('colorType: EColorType - 颜色类型'),
      Text('customColor: Color? - 自定义颜色'),
      Text('defaultColor: Color - 默认颜色'),
      Text('customHeight: double? - 自定义高度'),
      Text('customFontSize: double? - 自定义字体大小'),
      Text('customBorderRadius: double? - 自定义圆角大小'),
      Text('onSelect: ValueChanged<String?>? - 选择日期时的回调函数'),
      SizedBox(height: 16),
      Text('Calendar 属性',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Text('initialDate: String? - 初始日期值'),
      Text('type: CalendarType - 日历类型'),
      Text('minDate: DateTime? - 可选的最小日期'),
      Text('maxDate: DateTime? - 可选的最大日期'),
      Text('format: String? - 日期格式'),
      Text('weekDate: bool - 是否显示周视图'),
      Text('onSelect: ValueChanged<dynamic>? - 选择日期时的回调函数'),
      Text('prevMonth: Widget? - 上个月按钮'),
      Text('nextMonth: Widget? - 下个月按钮'),
      Text('prevYear: Widget? - 上一年按钮'),
      Text('nextYear: Widget? - 下一年按钮'),
    ],
  );
}
