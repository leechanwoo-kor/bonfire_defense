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

  const UnitSelectionInterface({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    OverlayProvider overlayProvider = Provider.of<OverlayProvider>(context);

    return Consumer<DefenderStateProvider>(builder: (context, state, child) {
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
                        onTap: () => placeDefender(
                            context, type, overlayProvider, state),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  void placeDefender(BuildContext context, DefenderType type,
      OverlayProvider overlayProvider, DefenderStateProvider state) {
    state.setSelectedDefender(type);
  }

  Widget _buildUnitCard(BuildContext context,
      {required DefenderType type, VoidCallback? onTap}) {
    int cost = defenderCosts[type]!;
    GameStateProvider gameState = Provider.of<GameStateProvider>(context);

    DefenderStateProvider defenderState =
        Provider.of<DefenderStateProvider>(context, listen: true);

    bool canAfford = gameState.gold >= cost;
    double opacity = canAfford ? 1.0 : 0.5;
    bool isSelected = defenderState.selectedDefender == type;

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
      onTap: gameState.gold >= cost ? onTap : null,
      child: Opacity(
        opacity: opacity,
        child: Card(
          color: Colors.white,
          shadowColor: isSelected ? Colors.yellowAccent : Colors.black,
          elevation: isSelected ? 8.0 : 2.0,
          shape: isSelected
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.yellowAccent, width: 2))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Special Ability'),
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
