import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitSelectionOverlay extends StatelessWidget {
  static String overlayName = 'unitSelectionOverlay';
  final GameController controller;

  const UnitSelectionOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    OverlayProvider overlayProvider = Provider.of<OverlayProvider>(context);

    return Consumer<GameController>(builder: (context, controller, child) {
      if (overlayProvider.isActive(UnitSelectionOverlay.overlayName)) {
        return Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildUnitCard(
                    context,
                    image: const AssetImage('assets/images/arch.png'),
                    title: '궁수 배치',
                    onTap: controller.getDefenderCount(DefenderType.arch) > 0
                        ? null
                        : () {
                            controller.addDefender(DefenderType.arch,
                                controller.placementPosition);
                            overlayProvider.setActive(
                                UnitSelectionOverlay.overlayName, false);
                          },
                  ),
                  _buildUnitCard(
                    context,
                    image: const AssetImage('assets/images/knight.png'),
                    title: '기사 배치',
                    onTap: controller.getDefenderCount(DefenderType.knight) > 0
                        ? null
                        : () {
                            controller.addDefender(DefenderType.knight,
                                controller.placementPosition);
                            overlayProvider.setActive(
                                UnitSelectionOverlay.overlayName, false);
                          },
                  ),
                  _buildUnitCard(
                    context,
                    image: const AssetImage('assets/images/lancer.png'),
                    title: '창병 배치',
                    onTap: controller.getDefenderCount(DefenderType.lancer) > 0
                        ? null
                        : () {
                            controller.addDefender(DefenderType.lancer,
                                controller.placementPosition);
                            overlayProvider.setActive(
                                UnitSelectionOverlay.overlayName, false);
                          },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  overlayProvider.setActive(
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

  Widget _buildUnitCard(BuildContext context,
      {required AssetImage image, required String title, VoidCallback? onTap}) {
    bool isDisabled = onTap == null;
    double opacity = isDisabled ? 0.5 : 1.0;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: image, height: 80),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
