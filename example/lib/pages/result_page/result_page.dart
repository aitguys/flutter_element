import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result 结果'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            EResult(
              status: EResultStatus.success,
              title: '提交成功',
              subTitle: '请耐心等待审核',
              extra: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: null,
                    child: Text('返回列表'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('查看详情'),
                  ),
                ],
              ),
            ),
            Divider(),
            EResult(
              status: EResultStatus.warning,
              title: '警告提示',
              subTitle: '请注意相关信息',
            ),
            Divider(),
            EResult(
              status: EResultStatus.info,
              title: '信息提示',
              subTitle: '这是一条信息',
            ),
            Divider(),
            EResult(
              status: EResultStatus.error,
              title: '错误提示',
              subTitle: '请检查并修改以下信息后，再重新提交。',
              extra: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: null,
                    child: Text('返回修改'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
