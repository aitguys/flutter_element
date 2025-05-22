// import 'package:flutter/material.dart';
// import 'package:flutter_element/src/components/input/input.dart';

// class InputPage extends StatefulWidget {
//   const InputPage({Key? key}) : super(key: key);

//   @override
//   State<InputPage> createState() => _InputPageState();
// }

// class _InputPageState extends State<InputPage> {
//   String value = '';
//   String value2 = '';
//   String value3 = '';
//   String value4 = '';
//   String value5 = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('EInput 测试')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: ListView(
//           children: [
//             const Text('基础用法'),
//             EInput(
//               value: value,
//               onChanged: (v) {
//                 print('onChange: $v');
//                 setState(() => value = v);
//               },
//               placeholder: '请输入内容',
//               onFocus: () => print('onFocus'),
//               onBlur: () => print('onBlur'),
//             ),
//             const SizedBox(height: 24),
//             const Text('可清空'),
//             EInput(
//               value: value2,
//               onChanged: (v) => setState(() => value2 = v),
//               placeholder: '可清空输入框',
//               clearable: true,
//             ),
//             const SizedBox(height: 24),
//             const Text('带前缀/后缀'),
//             EInput(
//               value: value3,
//               onChanged: (v) => setState(() => value3 = v),
//               placeholder: '带图标',
//               prefix: const Icon(Icons.search, size: 18),
//               suffix:
//                   const Icon(Icons.check_circle, size: 18, color: Colors.green),
//             ),
//             const SizedBox(height: 24),
//             const Text('禁用'),
//             EInput(
//               value: '不可编辑',
//               onChanged: (_) {},
//               disabled: true,
//               placeholder: '禁用',
//             ),
//             const SizedBox(height: 24),
//             const Text('只读'),
//             EInput(
//               value: '只读内容',
//               onChanged: (_) {},
//               readOnly: true,
//               placeholder: '只读',
//             ),
//             EInput(
//               value: '只读内容',
//               onChanged: (_) {},
//               readOnly: true,
//               placeholder: '只读',
//               height: 100,
//             ),
//             const SizedBox(height: 24),
//             const Text('不同尺寸'),
//             Row(
//               children: [
//                 Expanded(
//                   child: EInput(
//                     value: value4,
//                     onChanged: (v) => setState(() => value4 = v),
//                     placeholder: '小',
//                     size: EInputSize.small,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: EInput(
//                     value: value5,
//                     onChanged: (v) => setState(() => value5 = v),
//                     placeholder: '大',
//                     size: EInputSize.large,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
