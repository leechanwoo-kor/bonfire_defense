import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/stats_provider.dart';
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
            child: Selector<GameController, int>(
              selector: (_, controller) => controller.stage,
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
                          onPressed: () => Provider.of<GameController>(context,
                                  listen: false)
                              .activateSpecialAbility(),
                          child: const Text('Special Ability'),
                        ),
                        Selector<GameController, bool>(
                          selector: (_, controller) => controller.isRunning,
                          builder: (context, isRunning, __) => ElevatedButton(
                            onPressed: isRunning
                                ? null
                                : () {
                                    Provider.of<GameController>(context,
                                            listen: false)
                                        .startStage();
                                  },
                            style: ElevatedButton.styleFrom(
                              disabledForegroundColor:
                                  Colors.grey.withOpacity(0.38),
                              disabledBackgroundColor: Colors.grey
                                  .withOpacity(0.12), // Color when disabled
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
                      Selector<StatsProvider, int>(
                        selector: (_, stats) => stats.count,
                        builder: (_, count, __) => Text(
                          'Count: $count',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Selector<StatsProvider, int>(
                        selector: (_, stats) => stats.life,
                        builder: (_, life, __) => Text(
                          'Life❤️: $life',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Selector<StatsProvider, int>(
                        selector: (_, stats) => stats.score,
                        builder: (_, score, __) => Text(
                          'Score: $score',
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
