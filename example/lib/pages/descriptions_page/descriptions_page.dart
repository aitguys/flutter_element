import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class DescriptionsPage extends StatelessWidget {
  const DescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Descriptions 描述列表')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('基础用法'),
            SizedBox(height: 16),
            EDescriptions(
              title: '用户信息',
              items: [
                EDescriptionItem(label: '用户名', content: Text('张三')),
                EDescriptionItem(label: '手机号', content: Text('12345678901')),
                EDescriptionItem(label: '住址', content: Text('北京市朝阳区')),
                EDescriptionItem(label: '备注', content: Text('VIP用户')),
              ],
            ),
            SizedBox(height: 32),
            Text('带边框'),
            SizedBox(height: 16),
            EDescriptions(
              title: '订单信息',
              border: true,
              items: [
                EDescriptionItem(label: '订单号', content: Text('20240601001')),
                EDescriptionItem(label: '下单时间', content: Text('2024-06-01')),
                EDescriptionItem(label: '状态', content: Text('已支付')),
                EDescriptionItem(label: '金额', content: Text('¥100.00')),
              ],
            ),
            SizedBox(height: 32),
            Text('两列布局'),
            SizedBox(height: 16),
            EDescriptions(
              title: '商品信息',
              column: 2,
              items: [
                EDescriptionItem(label: '商品名', content: Text('iPhone 15')),
                EDescriptionItem(label: '颜色', content: Text('黑色')),
                EDescriptionItem(label: '容量', content: Text('256GB')),
                EDescriptionItem(label: '价格', content: Text('¥6999')),
              ],
            ),
            SizedBox(height: 32),
            Text('小尺寸'),
            SizedBox(height: 16),
            EDescriptions(
              title: '简要信息',
              size: EDescriptionsSize.small,
              items: [
                EDescriptionItem(label: 'A', content: Text('1')),
                EDescriptionItem(label: 'B', content: Text('2')),
                EDescriptionItem(label: 'C', content: Text('3')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
