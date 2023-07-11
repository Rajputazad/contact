import 'package:flutter/services.dart';

class NoEmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any emoji characters from the new value
    // ignore: valid_regexps
    final sanitizedText = newValue.text.replaceAll(RegExp(r'[\u{1F300}-\u{1F64F}]'), '');

    return TextEditingValue(
      text: sanitizedText,
      selection: newValue.selection,
    );
  }
}
