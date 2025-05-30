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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('DatePicker 属性',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      DataTable(
        columns: const [
          DataColumn(label: Text('属性')),
          DataColumn(label: Text('说明')),
          DataColumn(label: Text('类型')),
          DataColumn(label: Text('可选值')),
          DataColumn(label: Text('默认值')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('type')),
            DataCell(Text('日期选择器类型')),
            DataCell(Text('DatePickerType')),
            DataCell(Text('date / daterange / datetime / datetimerange')),
            DataCell(Text('date')),
          ]),
          DataRow(cells: [
            DataCell(Text('value')),
            DataCell(Text('绑定值')),
            DataCell(Text('DateTime')),
            DataCell(Text('-')),
            DataCell(Text('-')),
          ]),
          DataRow(cells: [
            DataCell(Text('placeholder')),
            DataCell(Text('非范围选择时的占位内容')),
            DataCell(Text('String')),
            DataCell(Text('-')),
            DataCell(Text('-')),
          ]),
          DataRow(cells: [
            DataCell(Text('size')),
            DataCell(Text('输入框尺寸')),
            DataCell(Text('ESizeItem')),
            DataCell(Text('small / medium / large')),
            DataCell(Text('medium')),
          ]),
          DataRow(cells: [
            DataCell(Text('disabled')),
            DataCell(Text('是否禁用')),
            DataCell(Text('bool')),
            DataCell(Text('-')),
            DataCell(Text('false')),
          ]),
          DataRow(cells: [
            DataCell(Text('format')),
            DataCell(Text('显示在输入框中的格式')),
            DataCell(Text('String')),
            DataCell(Text('-')),
            DataCell(Text('yyyy-MM-dd')),
          ]),
          DataRow(cells: [
            DataCell(Text('onChange')),
            DataCell(Text('用户确认选定的值时触发')),
            DataCell(Text('Function')),
            DataCell(Text('-')),
            DataCell(Text('-')),
          ]),
        ],
      ),
    ],
  );
} 