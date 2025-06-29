import 'package:flutter/material.dart';
import 'package:flutter_element_example/logger/logger.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Basic Links',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Default Link',
                  colorType: EColorType.default_,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  colorType: EColorType.primary,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  colorType: EColorType.success,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  colorType: EColorType.warning,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  colorType: EColorType.danger,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  colorType: EColorType.info,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Disabled Links',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Default Link',
                  colorType: EColorType.default_,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  colorType: EColorType.primary,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  colorType: EColorType.success,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  colorType: EColorType.warning,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  colorType: EColorType.danger,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  colorType: EColorType.info,
                  disabled: true,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Links with Icons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Edit',
                  colorType: EColorType.primary,
                  icon: Icons.edit,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Delete',
                  colorType: EColorType.danger,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                ELink(
                  text: 'View',
                  colorType: EColorType.info,
                  icon: Icons.visibility,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Links without Underline',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Default Link',
                  colorType: EColorType.default_,
                  underline: false,
                  target: '_blank',
                ),
                ELink(
                  text: 'Primary Link',
                  colorType: EColorType.primary,
                  underline: false,
                ),
                ELink(
                  text: 'Success Link',
                  colorType: EColorType.success,
                  underline: false,
                ),
              ],
            ),
            const Text('Links with Href, target, onPressed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Default Link',
                  colorType: EColorType.default_,
                  underline: false,
                  target: '_blank',
                  href: 'https://www.flutter-element.com',
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  colorType: EColorType.primary,
                  underline: false,
                  onPressed: () {
                    Loglevel.d('onPressed');
                  },
                ),
                ELink(
                  text: 'Success Link',
                  colorType: EColorType.success,
                  underline: false,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
