import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameControlPanel extends StatelessWidget {
  const GameControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blueGrey.withOpacity(0.8),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Selector<GameStateProvider, bool>(
              selector: (_, state) => state.state == GameState.waving,
              builder: (context, isWaving, __) => ElevatedButton(
                onPressed: isWaving
                    ? null
                    : () {
                        Provider.of<GameStateProvider>(context, listen: false)
                            .startGame();
                      },
                style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                ),
                child: const Text('Start',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
