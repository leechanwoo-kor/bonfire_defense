import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
