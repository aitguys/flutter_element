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
import 'mention_page.dart';
import 'radio_page.dart';
import 'rate_page.dart';
import 'select_page.dart';
import 'slider_page.dart';
import 'avatar_page.dart';
import 'card_page.dart';
import 'carousel_page.dart';
import 'collapse_page.dart';
import 'descriptions_page.dart';
import 'empty_page.dart';
import 'image_page.dart';
import 'infinite_scroll_page.dart';
import 'pagination_page.dart';
import 'progress_page.dart';
import 'result_page.dart';
import 'skeleton_page.dart';
import 'table_page.dart';
import 'tag_page.dart';
import 'timeline_page.dart';
import 'package:flutter_element_example/tree.dart';
import 'package:flutter_element_example/pages/statistic/statistic.dart';
import 'package:flutter_element_example/pages/segmented/segmented.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Element Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Element Demo'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tree 树形控件'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TreePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Button 按钮'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ButtonPage()),
            ),
          ),
          ListTile(
            title: const Text('Link 链接'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LinkPage()),
            ),
          ),
          ListTile(
            title: const Text('Scrollbar 滚动条'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScrollbarPage()),
            ),
          ),
          ListTile(
            title: const Text('Autocomplete 自动完成'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AutocompletePage()),
            ),
          ),
          ListTile(
            title: const Text('Checkbox 多选框'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckboxPage()),
            ),
          ),
          ListTile(
            title: const Text('Color Picker 颜色选择器'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ColorPickerPage()),
            ),
          ),
          ListTile(
            title: const Text('Date Picker 日期选择器'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DatePickerPage()),
            ),
          ),
          ListTile(
            title: const Text('Time Picker 时间选择器'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TimePickerPage()),
            ),
          ),
          ListTile(
            title: const Text('Input 输入框'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InputPage()),
            ),
          ),
          ListTile(
            title: const Text('Input Number 数字输入框'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InputNumberPage()),
            ),
          ),
          ListTile(
            title: const Text('Input Tag 标签输入'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InputTagPage()),
            ),
          ),
          ListTile(
            title: const Text('Mention 提及'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MentionPage()),
            ),
          ),
          ListTile(
            title: const Text('Radio 单选框'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RadioPage()),
            ),
          ),
          ListTile(
            title: const Text('Rate 评分'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RatePage()),
            ),
          ),
          ListTile(
            title: const Text('Select 选择器'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectPage()),
            ),
          ),
          ListTile(
            title: const Text('Slider 滑块'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SliderPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Avatar 头像'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AvatarPage()),
            ),
          ),
          ListTile(
            title: const Text('Card 卡片'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CardPage()),
            ),
          ),
          ListTile(
            title: const Text('Carousel 走马灯'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarouselPage()),
            ),
          ),
          ListTile(
            title: const Text('Collapse 折叠面板'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CollapsePage()),
            ),
          ),
          ListTile(
            title: const Text('Descriptions 描述列表'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DescriptionsPage()),
            ),
          ),
          ListTile(
            title: const Text('Empty 空状态'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmptyPage()),
            ),
          ),
          ListTile(
            title: const Text('Image 图片'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ImagePage()),
            ),
          ),
          ListTile(
            title: const Text('InfiniteScroll 无限滚动'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InfiniteScrollPage()),
            ),
          ),
          ListTile(
            title: const Text('Pagination 分页'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaginationPage()),
            ),
          ),
          ListTile(
            title: const Text('Progress 进度条'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressPage()),
            ),
          ),
          ListTile(
            title: const Text('Result 结果'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResultPage()),
            ),
          ),
          ListTile(
            title: const Text('Skeleton 骨架屏'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SkeletonPage()),
            ),
          ),
          ListTile(
            title: const Text('Table 表格'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TablePage()),
            ),
          ),
          ListTile(
            title: const Text('Tag 标签'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TagPage()),
            ),
          ),
          ListTile(
            title: const Text('Timeline 时间线'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TimelinePage()),
            ),
          ),
          ListTile(
            title: const Text('Statistic 统计数值'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatisticPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Segmented 分段器'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SegmentedPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
