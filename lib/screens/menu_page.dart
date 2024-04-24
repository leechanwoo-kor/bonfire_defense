import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/util/stages.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff85a643),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  '/game',
                  arguments: GameStageEnum.main,
                ),
                child: const Text('Play'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/about'),
                child: const Text('About'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
