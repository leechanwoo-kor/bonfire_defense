import 'package:bonfire_defense/widgets/defender_selection_panel.dart';
import 'package:bonfire_defense/widgets/game_menu.dart';
import 'package:bonfire_defense/widgets/game_state_panel.dart';
import 'package:bonfire_defense/widgets/start_button.dart';
import 'package:flutter/material.dart';

class GameOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 20,
          left: 20,
          child: GameStatePanel(),
        ),
        const Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefenderSelectionPanel(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showGameMenu(context);
            },
          ),
        ),
        const StartButton(
          position: Offset(135, 80),
        ),
      ],
    );
  }
}
