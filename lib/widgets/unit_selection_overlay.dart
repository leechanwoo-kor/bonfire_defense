import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
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

    return Consumer<DefenderStateProvider>(builder: (context, state, child) {
      if (!overlayProvider.isActive(UnitSelectionOverlay.overlayName)) {
        return const SizedBox.shrink();
      }

      return Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: DefenderType.values
                  .map((type) => _buildUnitCard(
                        context,
                        type: type,
                        onTap: state.getDefenderCount(type) > 0
                            ? null
                            : () => placeDefender(
                                context, type, overlayProvider, state),
                      ))
                  .toList(),
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
    });
  }

  void placeDefender(BuildContext context, DefenderType type,
      OverlayProvider overlayProvider, DefenderStateProvider state) {
    if (state.placementPosition != null) {
      DefenderManager defenderManager = DefenderManager(context.read());
      defenderManager.addDefender(type, state.placementPosition);
      state.addDefender(type);
      overlayProvider.setActive(UnitSelectionOverlay.overlayName, false);
    }
  }

  Widget _buildUnitCard(BuildContext context,
      {required DefenderType type, VoidCallback? onTap}) {
    bool isDisabled = onTap == null;
    double opacity = isDisabled ? 0.5 : 1.0;

    String title;
    AssetImage image;
    switch (type) {
      case DefenderType.arch:
        title = '궁수 배치';
        image = const AssetImage('assets/images/arch.png');
        break;
      case DefenderType.knight:
        title = '기사 배치';
        image = const AssetImage('assets/images/knight.png');
        break;
      case DefenderType.lancer:
        title = '창병 배치';
        image = const AssetImage('assets/images/lancer.png');
        break;
      default:
        throw UnimplementedError('Defender type $type not supported');
    }

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
