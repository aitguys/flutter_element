import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class DatePickerRangeTestPreview extends StatefulWidget {
  const DatePickerRangeTestPreview({super.key});

  @override
  State<DatePickerRangeTestPreview> createState() => _DatePickerRangeTestPreviewState();
}

class _DatePickerRangeTestPreviewState extends State<DatePickerRangeTestPreview> {
  DateTimeRange? _selectedRange;
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '日期范围选择器测试',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // 基本用法
          const Text(
            '基本用法',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
              if (range != null) {
                print('选择了日期范围: ${range.start} 至 ${range.end}');
              }
            },
          ),
          const SizedBox(height: 20),
          
          // 自定义占位符和分隔符
          const Text(
            '自定义占位符和分隔符',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            startPlaceholder: '开始时间',
            endPlaceholder: '结束时间',
            separator: '到',
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
            },
          ),
          const SizedBox(height: 20),
          
          // 自定义格式
          const Text(
            '自定义日期格式',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            format: 'yyyy年MM月dd日',
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
            },
          ),
          const SizedBox(height: 20),
          
          // 限制日期范围
          const Text(
            '限制日期范围',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            minDate: DateTime.now().subtract(const Duration(days: 30)),
            maxDate: DateTime.now().add(const Duration(days: 30)),
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
            },
          ),
          const SizedBox(height: 20),
          
          // 不同尺寸
          const Text(
            '不同尺寸',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: EDatePickerRange(
                  size: ESizeItem.small,
                  onRangeSelect: (range) {
                    setState(() {
                      _selectedRange = range;
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: EDatePickerRange(
                  size: ESizeItem.medium,
                  onRangeSelect: (range) {
                    setState(() {
                      _selectedRange = range;
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: EDatePickerRange(
                  size: ESizeItem.large,
                  onRangeSelect: (range) {
                    setState(() {
                      _selectedRange = range;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // 自定义颜色
          const Text(
            '自定义颜色',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            colorType: EColorType.success,
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
            },
          ),
          const SizedBox(height: 20),
          
          // 禁用状态
          const Text(
            '禁用状态',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          EDatePickerRange(
            disabled: true,
            onRangeSelect: (range) {
              setState(() {
                _selectedRange = range;
              });
            },
          ),
          const SizedBox(height: 20),
          
          // 显示选中的范围
          if (_selectedRange != null) ...[
            const Text(
              '当前选中的日期范围:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('开始日期: ${_selectedRange!.start.toString().split(' ')[0]}'),
                  const SizedBox(height: 8),
                  Text('结束日期: ${_selectedRange!.end.toString().split(' ')[0]}'),
                  const SizedBox(height: 8),
                  Text('总天数: ${_selectedRange!.duration.inDays + 1}'),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

