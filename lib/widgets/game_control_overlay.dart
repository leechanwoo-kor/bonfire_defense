import 'package:bonfire_defense/components/defenderCard.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameControlOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameControlOverlay({super.key});

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
                  UnitSelectionInterface(
                    selectedTypes: defenderState.availableDefenders.toList(),
                    gold: gameState.gold,
                    selectedDefender: defenderState.selectedDefender,
                    selectedDefenderIndex: defenderState.selectedDefenderIndex,
                    placeDefender: placeDefender,
                  ),
                  const GameControlButtons(),
                  const GameStatusBar(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class GameStageDisplay extends StatelessWidget {
  const GameStageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameStateProvider, int>(
      selector: (_, state) => state.currentStage,
      builder: (_, stage, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Stage: $stage',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class UnitSelectionInterface extends StatelessWidget {
  final List<DefenderType> selectedTypes;
  final int gold;
  final DefenderType? selectedDefender;
  final int? selectedDefenderIndex;
  final Function(BuildContext, int, DefenderType) placeDefender;

  const UnitSelectionInterface({
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
              DefenderCard card =
                  DefenderCard.getCards().firstWhere((c) => c.type == type);
              bool canAfford = gold >= card.cost;
              bool isSelected =
                  selectedDefender == type && selectedDefenderIndex == index;

              return UnitCard(
                index: index,
                card: card,
                canAfford: canAfford,
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

class UnitCard extends StatelessWidget {
  final int index;
  final DefenderCard card;
  final bool canAfford;
  final bool isSelected;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.index,
    required this.card,
    required this.canAfford,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canAfford ? onTap : null,
      child: Opacity(
        opacity: canAfford ? 1.0 : 0.5,
        child: Card(
          color: Colors.white,
          shadowColor: isSelected ? Colors.yellowAccent : Colors.black,
          elevation: isSelected ? 8.0 : 2.0,
          shape: isSelected
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.yellowAccent, width: 2))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  card.name,
                  style: TextStyle(
                    color: canAfford ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Image(image: AssetImage(card.imagePath), height: 80),
                const SizedBox(height: 4),
                Text(
                  '${card.cost}G',
                  style: TextStyle(
                    color: canAfford ? Colors.black : Colors.grey,
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

class GameControlButtons extends StatelessWidget {
  const GameControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.blueGrey.withOpacity(0.8),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                    (route) => false);
              },
              child: const Text('Menu'),
            ),
            Selector<GameStateProvider, int>(
              selector: (_, state) => state.gold,
              builder: (context, gold, __) => ElevatedButton(
                onPressed: gold >= 10
                    ? () {
                        Provider.of<GameStateProvider>(context, listen: false)
                            .updateGold(-10);
                        Provider.of<DefenderStateProvider>(context,
                                listen: false)
                            .shuffleDefenders();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                ),
                child: const Text('Reroll(10G)'),
              ),
            ),
            Selector<GameStateProvider, bool>(
              selector: (_, state) => state.state == GameState.waving,
              builder: (context, isWaving, __) => ElevatedButton(
                onPressed: isWaving
                    ? null
                    : () {
                        Provider.of<GameStateProvider>(context, listen: false)
                            .startGame();
                      },
                style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                ),
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameStatusBar extends StatelessWidget {
  const GameStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.count,
            builder: (_, count, __) => Text(
              'Count: $count',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.life,
            builder: (context, life, __) => Row(
              children: [
                Image.asset('assets/images/icons/HeartFull.png',
                    width: 36.0, height: 36.0),
                Text(
                  ': $life',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.gold,
            builder: (context, gold, __) => Row(
              children: [
                Image.asset('assets/images/icons/Coin.png',
                    width: 52.0, height: 52.0),
                Text(
                  ': $gold',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
