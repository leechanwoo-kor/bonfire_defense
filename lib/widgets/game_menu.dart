import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:flutter/material.dart';

class GameMenu extends StatefulWidget {
  final VoidCallback? onRestart;

  const GameMenu({super.key, required this.onRestart});

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
            const SizedBox(height: 20), // 여백 추가
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
                    widget.onRestart!();
                    Navigator.of(context).pop();
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
                            builder: (context) => const MenuPage()),
                        (route) => false);
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
