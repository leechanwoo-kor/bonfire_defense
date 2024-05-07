import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameControlOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameControlOverlay({super.key});

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
                Container(
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
                                MaterialPageRoute(
                                    builder: (context) => const MenuPage()),
                                (route) => false);
                          },
                          child: const Text('Menu'),
                        ),
                        ElevatedButton(
                          onPressed: () => {},
                          child: const Text('Special Ability'),
                        ),
                        Selector<GameStateProvider, bool>(
                          selector: (_, state) =>
                              state.state == GameState.waving,
                          builder: (context, isWaving, __) => ElevatedButton(
                            onPressed: isWaving
                                ? null
                                : () {
                                    Provider.of<GameStateProvider>(context,
                                            listen: false)
                                        .startGame();
                                  },
                            style: ElevatedButton.styleFrom(
                              disabledForegroundColor:
                                  Colors.grey.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.grey.withOpacity(0.12),
                            ),
                            child: const Text('Start'),
                          ),
                        ),

                        // Additional buttons can be added here if needed.
                      ],
                    ),
                  ),
                ),
                Container(
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Selector<GameStateProvider, int>(
                        selector: (_, state) => state.life,
                        builder: (_, life, __) => Text(
                          'Life❤️: $life',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Selector<GameStateProvider, int>(
                        selector: (_, state) => state.gold,
                        builder: (_, gold, __) => Text(
                          'Gold🪙: $gold',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
