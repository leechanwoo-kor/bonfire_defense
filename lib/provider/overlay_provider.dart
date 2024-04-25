import 'package:flutter/material.dart';

class OverlayProvider with ChangeNotifier {
  final Map<String, bool> _overlaysActive = {};

  bool isActive(String overlayName) {
    return _overlaysActive[overlayName] ?? false;
  }

  void setActive(String overlayName, bool isActive) {
    if (_overlaysActive[overlayName] != isActive) {
      _overlaysActive[overlayName] = isActive;
      notifyListeners();
    }
  }
}
