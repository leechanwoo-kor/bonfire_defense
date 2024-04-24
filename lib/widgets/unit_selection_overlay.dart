import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/util/stage_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitSelectionOverlay extends StatelessWidget {
  static String overlayName = 'unitSelectionOverlay';
  final GameController controller;

  const UnitSelectionOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(builder: (context, controller, child) {
      if (controller.isOverlayActive(UnitSelectionOverlay.overlayName)) {
        return Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.8), // 반투명 검은색 배경
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('유닛을 선택하세요', style: TextStyle(color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  controller.addDefender(
                      DefenderType.arch, controller.placementPosition);
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                  print('궁수 배치');
                },
                child: const Text('궁수 배치'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.addDefender(
                      DefenderType.knight, controller.placementPosition);
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                  print('기사 배치');
                },
                child: const Text('기사 배치'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.addDefender(
                      DefenderType.lancer, controller.placementPosition);
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                  print('창병 배치');
                },
                child: const Text('창병 배치'),
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
