import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefenderInfoDialog extends StatelessWidget {
  final Defender defender;
  final DefenderInfo defenderInfo;
  final VoidCallback onClose;
  final VoidCallback onSell;
  final VoidCallback? onMerge;

  const DefenderInfoDialog({
    super.key,
    required this.defender,
    required this.defenderInfo,
    required this.onClose,
    required this.onSell,
    required this.onMerge,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            width: 250.0,
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(defenderInfo.imagePath,
                        width: 50.0, height: 50.0),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(defenderInfo.name.replaceAll("\n", ' '),
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text("Attack Power: ${defender.attackDamage}"),
                          Text("Attack Type: ${defenderInfo.attackType}"),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onSell,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, elevation: 4.0),
                      child: const Text("Sell"),
                    ),
                    const SizedBox(width: 10),
                    Consumer<GameStateProvider>(
                      builder: (context, gameState, child) {
                        return ElevatedButton(
                          onPressed: onMerge,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  onMerge != null ? Colors.green : Colors.grey,
                              elevation: 4.0),
                          child: const Text("Merge(50G)"),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 4.0,
            top: 4.0,
            child: InkResponse(
              onTap: onClose,
              child: Image.asset('assets/images/icons/X.png',
                  width: 50.0, height: 50.0),
            ),
          ),
        ],
      ),
    );
  }
}
