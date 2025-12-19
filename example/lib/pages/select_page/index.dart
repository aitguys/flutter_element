import 'package:flutter/material.dart';
import 'select_basic.dart';
import 'select_multiple.dart';
import 'select_disable.dart';
import 'select_clearable.dart';
import 'select_prefix_suffix.dart';
import 'select_option_disable.dart';
import 'select_header.dart';
import 'select_api.dart';
import 'select_filterable.dart';

class SelectPreview extends StatelessWidget {
  const SelectPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SelectBasicPreview(),
          SelectMultiplePreview(),
          SelectDisablePreview(),
          SelectClearablePreview(),
          SelectFilterablePreview(),
          SelectPrefixSuffixPreview(),
          SelectOptionDisablePreview(),
          SelectHeaderPreview(),
          SelectApiPreview(),
        ],
      ),
    );
  }
}
