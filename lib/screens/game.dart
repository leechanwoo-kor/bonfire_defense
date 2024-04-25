import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:bonfire_defense/widgets/game_control_overlay.dart';
import 'package:bonfire_defense/widgets/unit_selection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BonfireDefense extends StatefulWidget {
  static const tileSize = GameConfig.tileSize;
  final GameConfig config;
  const BonfireDefense({
    super.key,
    required this.config,
  });

  @override
  State<BonfireDefense> createState() => _BonfireDefenseState();
}

class _BonfireDefenseState extends State<BonfireDefense> {
  late GameController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<GameController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final double mapWidth =
        widget.config.tilesInWidth * BonfireDefense.tileSize;
    final double mapHeight =
        widget.config.tilesInHeight * BonfireDefense.tileSize;

    return BonfireWidget(
      map: WorldMapByTiled(
        TiledReader.asset(widget.config.tiledMapPath),
        objectsBuilder: {
          'endGame': (properties) {
            return EndGameSensor(
              controller,
              position: properties.position,
              size: properties.size,
            );
          },
          'place': (properties) => PlaceableArea(
                position: properties.position,
                size: properties.size,
              ),
        },
      ),
      // backgroundColor: const Color(0xff85a643),
      cameraConfig: CameraConfig(
        initPosition: Vector2(mapWidth / 2, mapHeight / 2),
        moveOnlyMapArea: true,
        initialMapZoomFit: InitialMapZoomFitEnum.fitWidth,
      ),
      components: [
        controller,
      ],
      overlayBuilderMap: {
        GameControlOverlay.overlayName: (context, game) =>
            const GameControlOverlay(),
        UnitSelectionOverlay.overlayName: (context, game) =>
            UnitSelectionOverlay(
              controller: controller,
            ),
      },
      initialActiveOverlays: [
        GameControlOverlay.overlayName,
        UnitSelectionOverlay.overlayName,
      ],
    );
  }
}
