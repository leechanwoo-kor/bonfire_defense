import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/sensors/end_game_sensor.dart';
import 'package:bonfire_defense/widgets/game_overlay.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BonfireDefense extends StatefulWidget {
  static const tileSize = 16.0;

  const BonfireDefense({super.key});

  @override
  State<BonfireDefense> createState() => _BonfireDefenseState();
}

class _BonfireDefenseState extends State<BonfireDefense> {
  late GameController gameController;
  late GameConfig config;
  late BonfireGame _game;

  Offset? _lastOffset;
  Offset _startOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    gameController = GameController();

    config =
        Provider.of<GameConfigProvider>(context, listen: false).currentConfig;

    _buildGame();
  }

  void _buildGame() {
    final double mapWidth = config.tilesInWidth * BonfireDefense.tileSize;
    final double mapHeight = config.tilesInHeight * BonfireDefense.tileSize;

    double currentZoom = 1.1;

    _game = BonfireGame(
      context: context,
      map: WorldMapByTiled(
        TiledReader.asset(config.tiledMapPath),
        objectsBuilder: {
          'endGame': (properties) {
            return EndGameSensor(
              gameController,
              position: properties.position,
              size: properties.size,
            );
          },
          'place': (properties) => PlaceableArea(
                controller: gameController,
                position: properties.position,
                size: properties.size,
              ),
        },
      ),
      cameraConfig: CameraConfig(
        zoom: currentZoom,
        initPosition: Vector2(mapWidth / 2, mapHeight),
      ),
      components: [gameController],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (details) {
          _startOffset = details.localPosition;
        },
        onPanUpdate: (details) {
          if (_lastOffset != null) {
            final dx = (_startOffset.dx - details.localPosition.dx);
            final dy = (_startOffset.dy - details.localPosition.dy);
            gameController.moveCameraByOffset(Vector2(dx, dy));
          }
          _lastOffset = details.localPosition;
        },
        onPanEnd: (details) {
          _lastOffset = null;
        },
        child: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              if (pointerSignal.scrollDelta.dy > 0) {
                gameController.zoomOut();
              } else {
                gameController.zoomIn();
              }
            }
          },
          child: BonfireWidget(
            map: _game.map,
            cameraConfig: _game.camera.config,
            components:
                _game.world.children.whereType<GameComponent>().toList(),
            overlayBuilderMap: {
              GameOverlay.overlayName: (context, game) => const GameOverlay(),
            },
            initialActiveOverlays: const [
              GameOverlay.overlayName,
            ],
          ),
        ));
  }
}
