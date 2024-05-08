import 'dart:math';

import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameControlOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';
  final GameController controller;

  const GameControlOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Selector<GameStateProvider, int>(
              selector: (_, state) => state.currentStage,
              builder: (_, stage, __) => Text(
                'Stage: $stage',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UnitSelectionInterface(controller: controller),
                const GameControlButtons(),
                const GameStatusBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UnitSelectionInterface extends StatelessWidget {
  final GameController controller;
  final Random random = Random();

  UnitSelectionInterface({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    OverlayProvider overlayProvider = Provider.of<OverlayProvider>(context);

    return Consumer<DefenderStateProvider>(builder: (context, state, child) {
      List<DefenderType> selectedTypes =
          state.availableDefenders.take(3).toList();

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
                return _buildUnitCard(
                  context,
                  index: index,
                  type: selectedTypes[index],
                  onTap: () => placeDefender(context, index,
                      selectedTypes[index], overlayProvider, state),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  void placeDefender(BuildContext context, int index, DefenderType type,
      OverlayProvider overlayProvider, DefenderStateProvider state) {
    state.setSelectedDefender(type);
    state.setSelectedDefenderIndex(index);
  }

  Widget _buildUnitCard(BuildContext context,
      {required int index, required DefenderType type, VoidCallback? onTap}) {
    int cost = defenderCosts[type]!;
    GameStateProvider gameState = Provider.of<GameStateProvider>(context);

    DefenderStateProvider defenderState =
        Provider.of<DefenderStateProvider>(context, listen: true);

    bool canAfford = gameState.gold >= cost;
    double opacity = canAfford ? 1.0 : 0.5;
    bool isSelected = defenderState.selectedDefender == type &&
        defenderState.selectedDefenderIndex == index;

    String title;
    AssetImage image;
    switch (type) {
      case DefenderType.arch:
        title = 'Archer';
        image = const AssetImage('assets/images/arch.png');
        break;
      case DefenderType.knight:
        title = 'Knight';
        image = const AssetImage('assets/images/knight.png');
        break;
      case DefenderType.lancer:
        title = 'Lancer';
        image = const AssetImage('assets/images/lancer.png');
        break;
      case DefenderType.orcArcher:
        title = 'Orc Archer';
        image = const AssetImage('assets/images/arch.png');
        break;
      case DefenderType.orcWarrior:
        title = 'Orc Warrior';
        image = const AssetImage('assets/images/knight.png');
        break;
      default:
        throw UnimplementedError('Defender type $type not supported');
    }

    return GestureDetector(
      onTap: canAfford ? onTap : null,
      child: Opacity(
        opacity: opacity,
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
                  title,
                  style: TextStyle(
                    color: canAfford ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Image(image: image, height: 80),
                const SizedBox(height: 4),
                Text(
                  '${cost}G',
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

            // Additional buttons can be added here if needed.
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
            builder: (_, life, __) => Text(
              'Life❤️: $life',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.gold,
            builder: (_, gold, __) => Text(
              'Gold🪙: $gold',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
