import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/widgets/buttons/base_button.dart';

abstract class BasePanel<T extends BaseButton> extends GameDecoration {
  late List<T> buttons;
  T? selectedButton;

  BasePanel({required super.position, required super.size});

  void initializeButtons(List<T> buttons) {
    this.buttons = buttons;
    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  void onButtonTap(BaseButton tappedButton) {
    final tappedSpecificButton = tappedButton as T;
    if (selectedButton != null) {
      if (selectedButton == tappedSpecificButton) {
        handleSameButtonTap(tappedSpecificButton);
        return;
      } else {
        selectedButton!.isSelected = false;
      }
    }

    handleNewButtonTap(tappedSpecificButton);
  }

  void handleSameButtonTap(T tappedButton);

  void handleNewButtonTap(T tappedButton) {
    selectedButton = tappedButton;
    tappedButton.isSelected = true;
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
    selectedButton = null;
  }

  bool anyButtonTapped() {
    return buttons.any((button) => button.isTapped);
  }
}
