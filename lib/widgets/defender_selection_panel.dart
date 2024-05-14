import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
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
              Row(children: [
                const SizedBox(width: 4),
                RerollButton(
                    rerollDefenders: () => {
                          if (gameState.gold >= 10)
                            {
                              defenderState.shuffleDefenders(),
                              gameState.updateGold(-10)
                            }
                        }),
                const SizedBox(width: 4),
                DefenderCardsRow(
                    defenderState: defenderState, gold: gameState.gold),
              ]),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class RerollButton extends StatelessWidget {
  final VoidCallback rerollDefenders;

  const RerollButton({super.key, required this.rerollDefenders});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        final isDisabled = gameState.gold < 10;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: isDisabled ? Colors.grey : Colors.white,
          ),
          onPressed: isDisabled ? null : rerollDefenders,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: 48,
              height: 64,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icons/reroll.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
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
        final defender = defenderState.availableDefenders[index];
        final defenderInfo =
            DefenderInfo.getInfos().firstWhere((i) => i.type == defender.type);
        final isActivated = gold >= defenderInfo.cost;
        final isSelected = defenderState.selectedDefender == defender &&
            defenderState.selectedDefenderIndex == index;

        return UnitCard(
          defenderInfo: defenderInfo,
          isActivated: isActivated,
          isSelected: isSelected,
          onTap: () {
            defenderState.setSelectedDefender(defender);
            defenderState.setSelectedDefenderIndex(index);
          },
        );
      }),
    );
  }
}
