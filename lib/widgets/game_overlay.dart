import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/widgets/game_control_panel.dart';
import 'package:bonfire_defense/widgets/game_stage_display.dart';
import 'package:bonfire_defense/widgets/game_state_bar.dart';
import 'package:bonfire_defense/widgets/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameStateProvider, DefenderStateProvider>(
        builder: (context, gameState, defenderState, child) {
      void placeDefender(BuildContext context, int index, DefenderType type) {
        defenderState.setSelectedDefender(type);
        defenderState.setSelectedDefenderIndex(index);
      }

      return Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: GameStageDisplay(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefenderSelectionPanel(
                    selectedTypes: defenderState.availableDefenders.toList(),
                    gold: gameState.gold,
                    selectedDefender: defenderState.selectedDefender,
                    selectedDefenderIndex: defenderState.selectedDefenderIndex,
                    placeDefender: placeDefender,
                  ),
                  const GameControlPanel(),
                  const GameStateBar(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class DefenderSelectionPanel extends StatelessWidget {
  final List<DefenderType> selectedTypes;
  final int gold;
  final DefenderType? selectedDefender;
  final int? selectedDefenderIndex;
  final Function(BuildContext, int, DefenderType) placeDefender;

  const DefenderSelectionPanel({
    super.key,
    required this.selectedTypes,
    required this.gold,
    required this.selectedDefender,
    required this.selectedDefenderIndex,
    required this.placeDefender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(selectedTypes.length, (index) {
              DefenderType type = selectedTypes[index];
              DefenderInfo defenderInfo =
                  DefenderInfo.getInfos().firstWhere((c) => c.type == type);
              bool isActivated = gold >= defenderInfo.cost;
              bool isSelected =
                  selectedDefender == type && selectedDefenderIndex == index;

              return UnitCard(
                defenderInfo: defenderInfo,
                isActivated: isActivated,
                isSelected: isSelected,
                onTap: () => placeDefender(context, index, type),
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
