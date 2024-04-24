import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';

class InfoWidget extends StatelessWidget {
  static String overlayName = 'infoWidget';

  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Selector<GameController, int>(
              selector: (_, controller) => controller.count,
              builder: (_, count, __) => Text(
                'Count: $count',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Selector<GameController, int>(
              selector: (_, controller) => controller.life,
              builder: (_, life, __) => Text(
                'Life❤️: $life',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Selector<GameController, int>(
              selector: (_, controller) => controller.score,
              builder: (_, score, __) => Text(
                'Score: $score',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
