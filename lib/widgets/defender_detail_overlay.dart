import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_defense/components/defender.dart';

class DefenderInfoDialog extends StatelessWidget {
  final Defender defender;
  final VoidCallback onClose;
  final VoidCallback onSell;
  final VoidCallback onUpgrade;

  const DefenderInfoDialog({
    super.key,
    required this.defender,
    required this.onClose,
    required this.onSell,
    required this.onUpgrade,
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
                    Image.asset('assets/images/logo/bonfire.gif',
                        width: 50.0, height: 50.0),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${defenderNames[defender.type]}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Attack Power: ${defender.attackDamage}"),
                          Text("Attack Type: ${defenderType[defender.type]}"),
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
                    ElevatedButton(
                      onPressed: onUpgrade,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, elevation: 4.0),
                      child: const Text("Upgrade"),
                    ),
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