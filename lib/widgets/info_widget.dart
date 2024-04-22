import 'package:flutter/material.dart';
import 'package:bonfire_defense/components/game_controller.dart';

class InfoWidget extends StatelessWidget {
  static String overlayName = 'infoWidget';
  final GameController controller;

  const InfoWidget({super.key, required this.controller});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Health: ${controller.playerHealth}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              'Score: ${controller.score}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            // 여기에 더 많은 게임 정보를 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
