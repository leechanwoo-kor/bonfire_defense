import 'package:bonfire_defense/widgets/buttons/defense_tower_button.dart';
import 'package:bonfire_defense/widgets/buttons/tower_info_button.dart';

class ButtonsManager {
  TowerInfoButtons? activeTowerInfoButtons;
  TowerSelectButtons? activeTowerButtons;

  void displayTowerInfoButtons(TowerInfoButtons buttons) {
    activeTowerInfoButtons?.removeButtons();
    activeTowerInfoButtons?.removeFromParent();
    activeTowerInfoButtons = buttons;
  }

  void displayTowerButtons(TowerSelectButtons buttons) {
    activeTowerButtons?.removeButtons();
    activeTowerButtons?.removeFromParent();
    activeTowerButtons = buttons;
  }

  void handleBackgroundTap() {
    print("activeTowerButtons: $activeTowerButtons");
    print("activeTowerInfoButtons: $activeTowerInfoButtons");

    if (activeTowerInfoButtons != null) {
      final bool anyButtonTapped =
          activeTowerInfoButtons!.buttons.any((button) => button.isTapped);
      if (!anyButtonTapped) {
        activeTowerInfoButtons?.removeButtons();
        activeTowerInfoButtons?.removeFromParent();
        activeTowerInfoButtons = null;
      } else {
        for (var button in activeTowerInfoButtons!.buttons) {
          button.isTapped = false;
        }
      }
    }

    if (activeTowerButtons != null) {
      final bool anyButtonTapped =
          activeTowerButtons!.buttons.any((button) => button.isTapped);
      if (!anyButtonTapped) {
        activeTowerButtons?.removeButtons();
        activeTowerButtons?.removeFromParent();
        activeTowerButtons = null;
      } else {
        for (var button in activeTowerButtons!.buttons) {
          button.isTapped = false;
        }
      }
    }
  }
}
