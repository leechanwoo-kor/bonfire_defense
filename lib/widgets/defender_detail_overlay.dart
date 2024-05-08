import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_defense/components/defender.dart';

class DefenderInfoDialog extends StatelessWidget {
  final Defender defender;
  final VoidCallback onClose; // Changed from Function to VoidCallback
  final VoidCallback onSell; // Changed from Function to VoidCallback

  const DefenderInfoDialog({
    super.key,
    required this.defender,
    required this.onClose,
    required this.onSell,
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
            padding: const EdgeInsets.all(16.0),
            width: 300.0,
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Defender Information",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Type: ${defenderNames[defender.type]}"),
                Text(
                    "Position: (${defender.position.x}, ${defender.position.y})"),
                Text("Attack Interval: ${defender.attackInterval}ms"),
                Text("Vision Range: ${defender.visionRange} units"),
                ElevatedButton(
                  onPressed: onSell,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child:
                      Text("Sell (Get ${defenderCosts[defender.type]! ~/ 2}G)"),
                ),
              ],
            ),
          ),
          Positioned(
            right: 4.0,
            top: 4.0,
            child: InkResponse(
              onTap: onClose,
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
