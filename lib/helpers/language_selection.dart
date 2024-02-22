import 'package:flutter/material.dart';

class LanguageSelection {
  final Locale locale;
  final String label;

  LanguageSelection(this.locale, this.label);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageSelection &&
          runtimeType == other.runtimeType &&
          locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
