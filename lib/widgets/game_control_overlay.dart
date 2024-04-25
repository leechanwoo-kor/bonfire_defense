import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';

class GameControlOverlay extends StatelessWidget {
  static const String overlayName = 'gameControlOverlay';

  const GameControlOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    GameController controller =
        Provider.of<GameController>(context, listen: false);

    return Align(
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
                    onPressed: () => controller.activateSpecialAbility(),
                    child: const Text('Special Ability'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!controller.isRunning) {
                        controller.startStage(); // 게임 시작 기능
                      } else {
                        controller.pauseGame(); // 일시 정지 기능
                      }
                    },
                    child: Selector<GameController, bool>(
                      selector: (_, controller) => controller.isRunning,
                      builder: (_, isRunning, __) => Text(
                          isRunning ? 'Pause' : 'Start'), // 버튼 상태에 따라 텍스트 변경
                    ),
                  ),
                  // 필요하다면 여기에 더 많은 버튼을 추가할 수 있습니다.
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
        ],
      ),
    );
  }
}
