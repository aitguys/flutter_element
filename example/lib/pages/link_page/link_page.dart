import 'package:flutter/material.dart';
import 'package:flutter_element/flutter_element.dart';

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
                  type: ELinkType.Default,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.Primary,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.Success,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  type: ELinkType.Warning,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  type: ELinkType.Danger,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  type: ELinkType.Info,
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
                  type: ELinkType.Default,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.Primary,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.Success,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Warning Link',
                  type: ELinkType.Warning,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Danger Link',
                  type: ELinkType.Danger,
                  disabled: true,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Info Link',
                  type: ELinkType.Info,
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
                  type: ELinkType.Primary,
                  icon: Icons.edit,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Delete',
                  type: ELinkType.Danger,
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                ELink(
                  text: 'View',
                  type: ELinkType.Info,
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
                  type: ELinkType.Default,
                  underline: false,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Primary Link',
                  type: ELinkType.Primary,
                  underline: false,
                  onPressed: () {},
                ),
                ELink(
                  text: 'Success Link',
                  type: ELinkType.Success,
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
