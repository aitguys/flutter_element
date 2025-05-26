import 'package:flutter/material.dart';
import 'package:flutter_element/src/components/slider/slider.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value1 = 0;
  double _value2 = 0;
  double _value3 = 0;
  double _value4 = 0;
  double _value5 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider 滑块'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('默认值'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value1,
                    onChange: (value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('自定义初始值'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value2,
                    onChange: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('隐藏 Tooltip'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value3,
                    showTooltip: false,
                    onChange: (value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('格式化 Tooltip'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value4,
                    formatTooltip: (value) =>
                        (value / 100).toStringAsFixed(2),
                    onChange: (value) {
                      setState(() {
                        _value4 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('禁用状态'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value5,
                    disabled: true,
                    onChange: (value) {
                      setState(() {
                        _value5 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('不同尺寸'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('大尺寸'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value1,
                    size: ESliderSize.large,
                    onChange: (value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('默认尺寸'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value2,
                    size: ESliderSize.medium,
                    onChange: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('小尺寸'),
                const SizedBox(width: 20),
                Expanded(
                  child: ESlider(
                    value: _value3,
                    size: ESliderSize.small,
                    onChange: (value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('垂直模式'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('垂直滑块'),
                const SizedBox(width: 20),
                ESlider(
                  value: _value4,
                  vertical: true,
                  height: 200,
                  onChange: (value) {
                    setState(() {
                      _value4 = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
