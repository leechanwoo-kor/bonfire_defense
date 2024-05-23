import 'package:flutter/material.dart';

class TestStateProvider with ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void setVisible(bool visible) {
    _isVisible = visible;
    notifyListeners();
  }
}
