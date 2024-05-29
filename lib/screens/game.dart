import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/sensors/end_game_sensor.dart';
import 'package:bonfire_defense/widgets/buttons/start_button.dart';
import 'package:bonfire_defense/widgets/overlays/game_overlay.dart';
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

  Offset _startOffset = Offset.zero;
  double _currentZoom = 1.5;
  double _baseZoom = 1.5;

  @override
  void initState() {
    super.initState();
    gameController = GameController();
    _initializeGame();
  }

  void _initializeGame() {
    final config =
        Provider.of<GameConfigProvider>(context, listen: false).currentConfig;
    final double mapWidth = config.tilesInWidth * BonfireDefense.tileSize;
    final double mapHeight = config.tilesInHeight * BonfireDefense.tileSize;

    _game = BonfireGame(
      context: context,
      map: WorldMapByTiled(
        TiledReader.asset(config.tiledMapPath),
        objectsBuilder: {
          'endGame': (properties) => EndGameSensor(
                gameController,
                position: properties.position,
                size: properties.size,
              ),
          'place': (properties) => PlaceableArea(
                controller: gameController,
                position: properties.position,
                size: properties.size,
              ),
        },
      ),
      cameraConfig: CameraConfig(
        zoom: _currentZoom,
        initPosition: Vector2(mapWidth * 0.425, mapHeight),
      ),
      components: [
        gameController,
        StartButton(position: config.enemyInitialPosition)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          print("Background tapped");
          gameController.handleBackgroundTap();
        },
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        child: Listener(
          onPointerSignal: (pointerSignal) =>
              _handlePointerSignal(pointerSignal),
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
        ),
      ),
    ]);
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startOffset = details.focalPoint;
    _baseZoom = _currentZoom;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Handle zoom
      if (details.scale != 1.0) {
        double zoomDelta = (details.scale - 1);
        _currentZoom = (_baseZoom + zoomDelta).clamp(1.0, 3.0);
        gameController.cameraController.setZoom(_currentZoom);
      }

      // Handle pan
      final dx = (_startOffset.dx - details.focalPoint.dx);
      final dy = (_startOffset.dy - details.focalPoint.dy);
      gameController.cameraController.moveCameraByOffset(Vector2(dx, dy));
      _startOffset = details.focalPoint;
    });
  }

  void _handlePointerSignal(PointerSignalEvent pointerSignal) {
    if (pointerSignal is PointerScrollEvent) {
      if (pointerSignal.scrollDelta.dy > 0) {
        gameController.cameraController.zoomOut();
      } else {
        gameController.cameraController.zoomIn();
      }
    }
  }
}
