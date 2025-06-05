import 'package:flutter/material.dart';
import 'rate_basic.dart';
import 'rate_colors.dart';
import 'rate_size.dart';
import 'rate_half.dart';
import 'rate_text.dart';
import 'rate_score.dart';

class RatePreview extends StatelessWidget {
  const RatePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          RateBasicPreview(),
          RateColorsPreview(),
          RateSizePreview(),
          RateHalfPreview(),
          RateTextPreview(),
          RateScorePreview(),
        ],
      ),
    );
  }
}
