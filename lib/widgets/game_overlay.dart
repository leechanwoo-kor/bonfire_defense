import 'package:bonfire_defense/widgets/defender_selection_panel.dart';
import 'package:bonfire_defense/widgets/game_control_panel.dart';
import 'package:bonfire_defense/widgets/game_stage_display.dart';
import 'package:bonfire_defense/widgets/game_state_bar.dart';
import 'package:flutter/material.dart';

class GameOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
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
                DefenderSelectionPanel(),
                GameControlPanel(),
                GameStateBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}