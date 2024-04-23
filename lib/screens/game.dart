import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/components/game_controller.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/util/stage_config.dart';
import 'package:bonfire_defense/widgets/command_widget.dart';
import 'package:bonfire_defense/widgets/info_widget.dart';
import 'package:bonfire_defense/widgets/start_button.dart';
import 'package:bonfire_defense/widgets/unit_selection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BonfireDefense extends StatefulWidget {
  static const tileSize = 16.0;
  final StageConfig config;
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
  }

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<GameController>(context);

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
              position: properties.position,
              size: properties.size,
            );
          },
          'place': (properties) => PlaceableArea(
                position: properties.position,
                size: properties.size,
                placeable: true,
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
        StartButton.overlayName: (context, game) => StartButton(
              controller: controller,
            ),
        InfoWidget.overlayName: (context, game) => const InfoWidget(),
        CommandWidget.overlayName: (context, game) => CommandWidget(
              controller: controller,
            ),
        UnitSelectionOverlay.overlayName: (context, game) =>
            UnitSelectionOverlay(
              controller: controller,
            ),
      },
      initialActiveOverlays: [
        StartButton.overlayName,
        InfoWidget.overlayName,
        CommandWidget.overlayName,
        UnitSelectionOverlay.overlayName,
      ],
    );
  }
}
