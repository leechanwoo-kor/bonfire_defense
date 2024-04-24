class OverlayManager {
  final Map<String, bool> _overlaysActive = {};

  bool isActive(String overlayName) {
    return _overlaysActive[overlayName] ?? false;
  }

  void setActive(String overlayName, bool isActive) {
    if (_overlaysActive[overlayName] != isActive) {
      _overlaysActive[overlayName] = isActive;
      // 이 부분은 오버레이 상태가 변할 때 필요한 추가적인 동작을 수행할 수 있습니다.
    }
  }
}
