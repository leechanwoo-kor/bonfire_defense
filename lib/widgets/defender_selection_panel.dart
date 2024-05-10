import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/widgets/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefenderSelectionPanel extends StatelessWidget {
  const DefenderSelectionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameStateProvider, DefenderStateProvider>(
      builder: (context, gameState, defenderState, child) {
        return Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              RerollButton(
                  gold: gameState.gold, rerollDefenders: gameState.updateGold),
              DefenderCardsRow(
                  defenderState: defenderState, gold: gameState.gold),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class RerollButton extends StatelessWidget {
  final int gold;
  final Function rerollDefenders;

  const RerollButton(
      {super.key, required this.gold, required this.rerollDefenders});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: gold >= 10 ? () => rerollDefenders(-10) : null,
      style: ElevatedButton.styleFrom(
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      child: const Text('Reroll (10G)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}

class DefenderCardsRow extends StatelessWidget {
  final DefenderStateProvider defenderState;
  final int gold;

  const DefenderCardsRow(
      {super.key, required this.defenderState, required this.gold});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(defenderState.availableDefenders.length, (index) {
        final type = defenderState.availableDefenders[index];
        final defenderInfo =
            DefenderInfo.getInfos().firstWhere((info) => info.type == type);
        final isActivated = gold >= defenderInfo.cost;
        final isSelected = defenderState.selectedDefender == type &&
            defenderState.selectedDefenderIndex == index;

        return UnitCard(
          defenderInfo: defenderInfo,
          isActivated: isActivated,
          isSelected: isSelected,
          onTap: () {
            defenderState.setSelectedDefender(type);
            defenderState.setSelectedDefenderIndex(index);
          },
        );
      }),
    );
  }
}
