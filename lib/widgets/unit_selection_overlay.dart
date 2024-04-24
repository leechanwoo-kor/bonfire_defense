import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitSelectionOverlay extends StatelessWidget {
  static String overlayName = 'unitSelectionOverlay';
  const UnitSelectionOverlay({super.key, required GameController controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(builder: (context, controller, child) {
      if (controller.isOverlayActive(UnitSelectionOverlay.overlayName)) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('유닛을 선택하세요', style: TextStyle(color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                  print('궁수 배치');
                },
                child: const Text('궁수 배치'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                  print('기사 배치');
                },
                child: const Text('기사 배치'),
              ),
            ],
          ),
        );
      } else {
        return SizedBox.shrink(); // 오버레이가 비활성화된 경우 아무것도 표시하지 않음
      }
    });
  }
}
