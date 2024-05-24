import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameStatePanel extends StatelessWidget {
  const GameStatePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Selector<GameStateProvider, int>(
                  selector: (_, state) => state.life,
                  builder: (context, life, __) => Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ': $life',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Selector<GameStateProvider, int>(
                  selector: (_, state) => state.gold,
                  builder: (context, gold, __) => Row(
                    children: [
                      const Icon(
                        Icons.price_change,
                        color: Colors.yellow,
                        size: 18.0,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ': $gold',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        IntrinsicWidth(
          child: Container(
            height: 30,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Selector<GameStateProvider, int>(
              selector: (_, state) => state.count,
              builder: (_, count, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Count: $count',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



// Selector<GameStateProvider, int>(
//   selector: (_, state) => state.currentStage,
//   builder: (_, stage, __) => Padding(
//     padding: const EdgeInsets.only(bottom: 8.0),
//     child: Text(
//       'Stage: $stage',
//       style: const TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     ),
//   ),
// ),