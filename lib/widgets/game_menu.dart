import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({super.key});

  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  bool isBgmOn = true;
  bool isSoundOn = true;
  bool isVibrationOn = true;

  void toggleBgm() {
    setState(() {
      isBgmOn = !isBgmOn;
      // 여기에 BGM on/off 기능 구현
    });
  }

  void toggleSound() {
    setState(() {
      isSoundOn = !isSoundOn;
      // 여기에 Sound on/off 기능 구현
    });
  }

  void toggleVibration() {
    setState(() {
      isVibrationOn = !isVibrationOn;
      // 여기에 Vibration on/off 기능 구현
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.brown[200],
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: Colors.brown[900]!, width: 3),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '',
            style: TextStyle(
              fontSize: 24,
              color: Colors.brown[900],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.brown[900]),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(isBgmOn ? Icons.music_note : Icons.music_off),
                  color: Colors.brown[900],
                  onPressed: toggleBgm,
                ),
                IconButton(
                  icon: Icon(isSoundOn ? Icons.volume_up : Icons.volume_off),
                  color: Colors.brown[900],
                  onPressed: toggleSound,
                ),
                IconButton(
                  icon: Icon(
                      isVibrationOn ? Icons.vibration : Icons.do_not_disturb),
                  color: Colors.brown[900],
                  onPressed: toggleVibration,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BonfireDefense()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    '재시작',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    '나가기',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showGameMenu(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return const GameMenu();
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
}
