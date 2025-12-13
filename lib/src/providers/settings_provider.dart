import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSizeScale = 1.0;
  String _fontFamily = 'Inter'; // Default font
  bool _reduceMotion = false;
  bool _highContrast = false;

  double get fontSizeScale => _fontSizeScale;
  String get fontFamily => _fontFamily;
  bool get reduceMotion => _reduceMotion;
  bool get highContrast => _highContrast;

  void setFontSizeScale(double scale) {
    _fontSizeScale = scale;
    notifyListeners();
  }

  void setFontFamily(String family) {
    _fontFamily = family;
    notifyListeners();
  }

  void toggleReduceMotion(bool value) {
    _reduceMotion = value;
    notifyListeners();
  }

  void toggleHighContrast(bool value) {
    _highContrast = value;
    notifyListeners();
  }
}
