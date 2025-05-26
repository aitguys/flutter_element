import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

class DescriptionsPage extends StatelessWidget {
  const DescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Descriptions 描述列表')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            EDescriptions(
              title: '用户信息',
              items: [
                EDescriptionItem(label: '用户名', content: const Text('张三')),
                EDescriptionItem(label: '手机号', content: const Text('12345678901')),
                EDescriptionItem(label: '住址', content: const Text('北京市朝阳区')),
                EDescriptionItem(label: '备注', content: const Text('VIP用户')),
              ],
            ),
            const SizedBox(height: 32),
            const Text('带边框'),
            const SizedBox(height: 16),
            EDescriptions(
              title: '订单信息',
              border: true,
              items: [
                EDescriptionItem(label: '订单号', content: const Text('20240601001')),
                EDescriptionItem(label: '下单时间', content: const Text('2024-06-01')),
                EDescriptionItem(label: '状态', content: const Text('已支付')),
                EDescriptionItem(label: '金额', content: const Text('¥100.00')),
              ],
            ),
            const SizedBox(height: 32),
            const Text('两列布局'),
            const SizedBox(height: 16),
            EDescriptions(
              title: '商品信息',
              column: 2,
              items: [
                EDescriptionItem(label: '商品名', content: const Text('iPhone 15')),
                EDescriptionItem(label: '颜色', content: const Text('黑色')),
                EDescriptionItem(label: '容量', content: const Text('256GB')),
                EDescriptionItem(label: '价格', content: const Text('¥6999')),
              ],
            ),
            const SizedBox(height: 32),
            const Text('小尺寸'),
            const SizedBox(height: 16),
            EDescriptions(
              title: '简要信息',
              size: EDescriptionsSize.small,
              items: [
                EDescriptionItem(label: 'A', content: const Text('1')),
                EDescriptionItem(label: 'B', content: const Text('2')),
                EDescriptionItem(label: 'C', content: const Text('3')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
