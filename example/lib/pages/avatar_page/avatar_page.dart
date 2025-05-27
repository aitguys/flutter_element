import 'package:flutter/material.dart';
import 'package:flutter_element_plus/flutter_element_plus.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar 头像')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基础用法'),
            const SizedBox(height: 16),
            const Row(
              children: [
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
                  size: 50,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png',
                  size: 50,
                  shape: EAvatarShape.square,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('不同尺寸'),
            const SizedBox(height: 16),
            const Row(
              children: [
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
                  avatarSize: EAvatarSize.small,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
                  avatarSize: EAvatarSize.medium,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
                  avatarSize: EAvatarSize.large,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('展示类型'),
            const SizedBox(height: 16),
            const Row(
              children: [
                EAvatar(icon: Icons.person, size: 40),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
                  size: 40,
                ),
                SizedBox(width: 16),
                EAvatar(text: 'user', size: 40),
              ],
            ),
            const SizedBox(height: 32),
            const Text('加载失败回退'),
            const SizedBox(height: 16),
            Row(
              children: [
                EAvatar(
                  src: 'https://empty',
                  size: 60,
                  fallback: Image.network(
                      'https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png'),
                ),
                const SizedBox(width: 16),
                const EAvatar(
                  src: 'https://empty',
                  size: 60,
                  icon: Icons.person,
                ),
                const SizedBox(width: 16),
                const EAvatar(
                  src: 'https://empty',
                  size: 60,
                  text: 'A',
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('fit 适应容器'),
            const SizedBox(height: 16),
            const Row(
              children: [
                EAvatar(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  size: 60,
                  shape: EAvatarShape.square,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  size: 60,
                  shape: EAvatarShape.square,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  size: 60,
                  shape: EAvatarShape.square,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  size: 60,
                  shape: EAvatarShape.square,
                  fit: BoxFit.none,
                ),
                SizedBox(width: 16),
                EAvatar(
                  src:
                      'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                  size: 60,
                  shape: EAvatarShape.square,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
