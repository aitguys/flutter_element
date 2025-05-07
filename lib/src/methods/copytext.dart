import 'package:flutter/services.dart';

void copyToClipboard(String text) {
  if (text.isNotEmpty) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
