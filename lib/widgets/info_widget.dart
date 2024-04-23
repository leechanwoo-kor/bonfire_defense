import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/components/game_controller.dart';

class InfoWidget extends StatelessWidget {
  static String overlayName = 'infoWidget';

  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // listen: true를 추가하여 데이터 변경을 감지하고 위젯을 자동으로 업데이트
    final GameController controller =
        Provider.of<GameController>(context, listen: true);

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
              'Count: ${controller.count}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              'Score: ${controller.score}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
