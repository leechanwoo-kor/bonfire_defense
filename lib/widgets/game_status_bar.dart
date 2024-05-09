import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameStatusBar extends StatelessWidget {
  const GameStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.count,
            builder: (_, count, __) => Text(
              'Count: $count',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.life,
            builder: (context, life, __) => Row(
              children: [
                Image.asset('assets/images/icons/HeartFull.png',
                    width: 36.0, height: 36.0),
                Text(
                  ': $life',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Selector<GameStateProvider, int>(
            selector: (_, state) => state.gold,
            builder: (context, gold, __) => Row(
              children: [
                Image.asset('assets/images/icons/Coin.png',
                    width: 52.0, height: 52.0),
                Text(
                  ': $gold',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
