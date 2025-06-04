import 'package:flutter/material.dart';
import 'input_tag_custom_tag.dart';
import 'input_tag_prefix_suffix.dart';
import 'input_tag_max.dart';
import 'input_tag_delimiter.dart';
import 'input_tag_trigger.dart';
import 'input_tag_save_on_blur.dart';
import 'input_tag_clearable.dart';
import 'input_tag_disabled_readonly.dart';
import 'input_tag_size.dart';
import 'input_tag_custom_style.dart';
import 'input_tag_custom_color.dart';
import 'input_tag_api.dart';

class InputTagPreview extends StatelessWidget {
  const InputTagPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          InputTagCustomTagPreview(),
          InputTagPrefixSuffixPreview(),
          InputTagMaxPreview(),
          InputTagDelimiterPreview(),
          InputTagTriggerPreview(),
          InputTagSaveOnBlurPreview(),
          InputTagClearablePreview(),
          InputTagDisabledReadOnlyPreview(),
          InputTagSizePreview(),
          InputTagCustomStylePreview(),
          InputTagCustomColorPreview(),
          InputTagApiPreview(),
        ],
      ),
    );
  }
}
