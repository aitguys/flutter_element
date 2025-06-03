import 'package:flutter/material.dart';
import 'autocomplete_basic.dart';
import 'autocomplete_color.dart';
import 'autocomplete_fix.dart';
import 'autocomplete_clearable.dart';
import 'autocomplete_disable.dart';
import 'autocomplete_default_color.dart';
import 'autocomplete_api.dart';
import 'autocomplete_show_placeholder.dart';

class AutocompletePreview extends StatelessWidget {
  const AutocompletePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自动补全输入框'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AutocompleteBasicPreview(),
            AutocompleteColorPreview(),
            AutocompleteDefaultColorPreview(),
            AutocompleteFixPreview(),
            AutocompleteClearablePreview(),
            AutocompleteDisablePreview(),
            AutocompleteApiPreview(),
            AutocompleteShowPlaceholderPreview(),
          ],
        ),
      ),
    );
  }
}
