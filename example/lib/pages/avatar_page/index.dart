import 'package:flutter/material.dart';
import 'avatar_basic.dart';
import 'avatar_size.dart';
import 'avatar_type.dart';
import 'avatar_fallback.dart';
import 'avatar_fit.dart';

class AvatarPreview extends StatelessWidget {
  const AvatarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          AvatarBasicPreview(),
          AvatarSizePreview(),
          AvatarTypePreview(),
          AvatarFallbackPreview(),
          AvatarFitPreview(),
        ],
      ),
    );
  }
}
