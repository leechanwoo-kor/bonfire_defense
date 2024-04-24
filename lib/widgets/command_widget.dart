import 'package:flutter/material.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';

class CommandWidget extends StatelessWidget {
  static String overlayName = 'commandWidget';
  final GameController controller;

  const CommandWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        color: Colors.blueGrey.withOpacity(0.8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => controller.activateSpecialAbility(),
                child: const Text('Special Ability'),
              ),
              ElevatedButton(
                onPressed: () => controller.pauseGame(),
                child: const Text('Pause'),
              ),
              // 여기에 더 많은 게임 명령을 추가할 수 있습니다.
            ],
          ),
        ),
      ),
    );
  }
}
