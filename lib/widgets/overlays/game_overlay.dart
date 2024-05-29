import 'package:bonfire_defense/widgets/overlays/defender_selection_panel.dart';
import 'package:bonfire_defense/widgets/overlays/game_menu.dart';
import 'package:bonfire_defense/widgets/overlays/game_state_panel.dart';
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
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                showGameMenu(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
