import 'package:flutter/material.dart';
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
                  type: ELinkType.defaultType,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.primary,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.success,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  type: ELinkType.warning,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  type: ELinkType.danger,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  type: ELinkType.info,
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
                  type: ELinkType.defaultType,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.primary,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.success,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  type: ELinkType.warning,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  type: ELinkType.danger,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  type: ELinkType.info,
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
                  type: ELinkType.primary,
                  icon: Icons.edit,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Delete',
                  type: ELinkType.danger,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                ELink(
                  text: 'View',
                  type: ELinkType.info,
                  icon: Icons.visibility,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Links without Underline',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ELink(
                  text: 'Default Link',
                  type: ELinkType.defaultType,
                  underline: false,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.primary,
                  underline: false,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.success,
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
