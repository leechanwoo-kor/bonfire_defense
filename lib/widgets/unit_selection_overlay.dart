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
          color: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('유닛 배치', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildUnitCard(
                    image: const AssetImage('assets/images/arch.png'),
                    title: '궁수 배치',
                    onTap: () {
                      controller.addDefender(
                          DefenderType.arch, controller.placementPosition);
                      controller.setOverlayActive(
                          UnitSelectionOverlay.overlayName, false);
                    },
                  ),
                  _buildUnitCard(
                    image: const AssetImage('assets/images/knight.png'),
                    title: '기사 배치',
                    onTap: () {
                      controller.addDefender(
                          DefenderType.knight, controller.placementPosition);
                      controller.setOverlayActive(
                          UnitSelectionOverlay.overlayName, false);
                    },
                  ),
                  _buildUnitCard(
                    image: const AssetImage('assets/images/lancer.png'),
                    title: '창병 배치',
                    onTap: () {
                      controller.addDefender(
                          DefenderType.lancer, controller.placementPosition);
                      controller.setOverlayActive(
                          UnitSelectionOverlay.overlayName, false);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.setOverlayActive(
                      UnitSelectionOverlay.overlayName, false);
                },
                child: const Text('취소'),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildUnitCard({
    required AssetImage image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: image,
                height: 80,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
