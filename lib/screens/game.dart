import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/sensors/end_game_sensor.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/widgets/game_overlay.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BonfireDefense extends StatefulWidget {
  static const tileSize = 16.0;
  const BonfireDefense({
    super.key,
  });

  @override
  State<BonfireDefense> createState() => _BonfireDefenseState();
}

class _BonfireDefenseState extends State<BonfireDefense> {
  late GameController controller;
  late GameConfig config;
  late double _currentZoom;

  @override
  void initState() {
    super.initState();
    controller = GameController();
    config =
        Provider.of<GameConfigProvider>(context, listen: false).currentConfig;
    _currentZoom = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _currentZoom *= details.scale;
      _currentZoom = _currentZoom.clamp(0.8, 2.0);
    });
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        _currentZoom *= event.scrollDelta.dy > 0 ? 1.1 : 0.9;
        _currentZoom = _currentZoom.clamp(0.8, 2.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double mapWidth = config.tilesInWidth * BonfireDefense.tileSize;
    final double mapHeight = config.tilesInHeight * BonfireDefense.tileSize;

    return Listener(
      onPointerSignal: _onPointerSignal,
      child: GestureDetector(
        onScaleUpdate: _onScaleUpdate,
        child: BonfireWidget(
          map: WorldMapByTiled(
            TiledReader.asset(config.tiledMapPath),
            objectsBuilder: {
              'endGame': (properties) {
                return EndGameSensor(
                  controller,
                  position: properties.position,
                  size: properties.size,
                );
              },
              'place': (properties) => PlaceableArea(
                    controller: controller,
                    position: properties.position,
                    size: properties.size,
                  ),
            },
          ),
          // backgroundColor: const Color(0xff85a643),
          cameraConfig: CameraConfig(
            initPosition: Vector2(mapWidth / 2, mapHeight),
            moveOnlyMapArea: true,
            zoom: _currentZoom,
            initialMapZoomFit: InitialMapZoomFitEnum.fitWidth,
          ),
          components: [
            controller,
          ],
          overlayBuilderMap: {
            GameOverlay.overlayName: (context, game) => const GameOverlay(),
          },
          initialActiveOverlays: const [
            GameOverlay.overlayName,
          ],
        ),
      ),
    );
  }
}
