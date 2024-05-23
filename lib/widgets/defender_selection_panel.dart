import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/widgets/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefenderSelectionPanel extends StatefulWidget {
  const DefenderSelectionPanel({super.key});

  @override
  _DefenderSelectionPanelState createState() => _DefenderSelectionPanelState();
}

class _DefenderSelectionPanelState extends State<DefenderSelectionPanel> {
  bool _isVisible = false;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameStateProvider, DefenderStateProvider>(
      builder: (context, gameState, defenderState, child) {
        final isActivated = gameState.gold >= 10;

        return Column(
          children: [
            GestureDetector(
              onTap: _toggleVisibility,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                alignment: Alignment.center,
                child: Icon(
                  _isVisible ? Icons.arrow_downward : Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isVisible ? 200 : 0, // Adjust height as needed
              color: Colors.black.withOpacity(0.8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(children: [
                      const SizedBox(width: 4),
                      RerollButton(
                          isActivated: isActivated,
                          rerollDefenders: () => {
                                if (isActivated)
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
              ),
            ),
          ],
        );
      },
    );
  }
}

class RerollButton extends StatelessWidget {
  final VoidCallback rerollDefenders;
  final bool isActivated;

  const RerollButton(
      {super.key, required this.rerollDefenders, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor:
                !isActivated ? Colors.white.withOpacity(0.5) : Colors.white,
          ),
          onPressed: rerollDefenders,
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
