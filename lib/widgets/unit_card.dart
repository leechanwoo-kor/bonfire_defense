import 'package:bonfire_defense/components/defender_info.dart';
import 'package:flutter/material.dart';

class UnitCard extends StatelessWidget {
  final DefenderInfo defenderInfo;
  final bool isActivated;
  final bool isSelected;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.defenderInfo,
    required this.isActivated,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UnitInteraction(
        isActivated: isActivated,
        onTap: onTap,
        defenderInfo: defenderInfo,
        isSelected: isSelected);
  }
}

class UnitInteraction extends StatelessWidget {
  final DefenderInfo defenderInfo;
  final bool isActivated;
  final bool isSelected;
  final VoidCallback onTap;

  const UnitInteraction({
    super.key,
    required this.isActivated,
    required this.onTap,
    required this.defenderInfo,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActivated ? onTap : null,
      child: Opacity(
        opacity: isActivated ? 1.0 : 0.5,
        child: UnitCardDesign(
          defenderInfo: defenderInfo,
          isActivated: isActivated,
          isSelected: isSelected,
        ),
      ),
    );
  }
}

class UnitCardDesign extends StatelessWidget {
  final DefenderInfo defenderInfo;
  final bool isActivated;
  final bool isSelected;

  const UnitCardDesign(
      {super.key,
      required this.defenderInfo,
      required this.isActivated,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: isSelected ? Colors.yellowAccent : Colors.black,
      elevation: isSelected ? 8.0 : 2.0,
      shape: isSelected
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.yellowAccent, width: 2))
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UnitDisplay(
          defenderInfo: defenderInfo,
          isActivated: isActivated,
        ),
      ),
    );
  }
}

class UnitDisplay extends StatelessWidget {
  final DefenderInfo defenderInfo;
  final bool isActivated;

  const UnitDisplay({
    super.key,
    required this.defenderInfo,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          defenderInfo.name,
          style: TextStyle(
            color: isActivated ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image(image: AssetImage(defenderInfo.imagePath), height: 50, width: 50),
        Text(
          '${defenderInfo.cost}G',
          style: TextStyle(
            color: isActivated ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
