import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/archer_tower.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:bonfire_defense/widgets/buttons/base_button.dart';
import 'package:bonfire_defense/widgets/buttons/base_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TowerSelectionPanel extends BasePanel<TowerSelectionButton> {
  TowerInfoWidget? selectedInfoWidget;
  TransparentTower? transparentTower;

  TowerSelectionPanel({required super.position}) : super(size: Vector2.all(18));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initializeButtons([
      createButton(
          offset: Vector2(0, 20),
          icon: Icons.ac_unit,
          towerType: TowerType.barrack),
      createButton(
          offset: Vector2(20, 0),
          icon: Icons.arrow_forward,
          towerType: TowerType.archer),
      createButton(
          offset: Vector2(0, -20),
          icon: Icons.account_balance,
          towerType: TowerType.dwarf),
      createButton(
          offset: Vector2(-20, 0),
          icon: Icons.accessibility,
          towerType: TowerType.mage),
    ]);
  }

  TowerSelectionButton createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
  }) {
    return TowerSelectionButton(
      position: position + offset,
      icon: icon,
      onTapCallback: onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
    );
  }

  @override
  void handleSameButtonTap(TowerSelectionButton tappedButton) {
    final gameState = gameRef.context.read<GameStateProvider>();

    if (gameState.gold >= tappedButton.towerInfo.cost) {
      addTower(tappedButton.towerInfo);
      gameState.updateGold(-tappedButton.towerInfo.cost);
      transparentTower?.removeFromParent();
      transparentTower = null;
      selectedButton!.isSelected = false;
      selectedButton = null;
      selectedInfoWidget?.removeFromParent();
      selectedInfoWidget = null;
      removeButtons();
    } else {
      print('Not enough gold to add tower');
    }
  }

  void addTower(TowerInfo towerInfo) {
    Tower tower;
    switch (towerInfo.type) {
      // case TowerType.barrack:
      //   tower = BarrackTower(position.clone());
      //   break;
      case TowerType.archer:
        tower = ArcherTower(position.clone());
        break;
      // case TowerType.dwarf:
      //   tower = DwarfTower(position.clone());
      //   break;
      // case TowerType.mage:
      //   tower = MageTower(position.clone());
      //   break;
      default:
        throw Exception('Invalid TowerType');
    }
    gameRef.add(tower);
  }

  @override
  void handleNewButtonTap(TowerSelectionButton tappedButton) {
    super.handleNewButtonTap(tappedButton);
    updateInfoWidget(tappedButton.towerInfo);
    addTransparentTower(tappedButton.towerInfo);
  }

  void updateInfoWidget(TowerInfo towerInfo) {
    final mapCenterX = gameRef.map.size.x / 2;
    final infoPosition = position.x > mapCenterX
        ? position + Vector2(-140, -20)
        : position + Vector2(40, -20);

    selectedInfoWidget?.removeFromParent();
    selectedInfoWidget = TowerInfoWidget(
      towerInfo: towerInfo,
      position: infoPosition,
    );
    gameRef.add(selectedInfoWidget!);
  }

  void addTransparentTower(TowerInfo towerInfo) {
    transparentTower?.removeFromParent();

    transparentTower = TransparentTower(
      position: position - Vector2(0, 16),
      towerInfo: towerInfo,
    );
    gameRef.add(transparentTower!);
  }

  @override
  void removeButtons() {
    super.removeButtons();
    selectedInfoWidget?.removeFromParent();
    selectedInfoWidget = null;
    transparentTower?.removeFromParent();
    transparentTower = null;
  }
}

class TowerSelectionButton extends BaseButton {
  TowerSelectionButton({
    required super.position,
    required super.icon,
    required super.onTapCallback,
    required super.towerInfo,
  }) : super(
          size: Vector2.all(16),
        );
}

class TowerInfoWidget extends GameDecoration {
  final TowerInfo towerInfo;

  TowerInfoWidget({
    required this.towerInfo,
    required super.position,
  }) : super(size: Vector2(120, 60));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    drawBackground(canvas);
    drawText(canvas);
  }

  void drawBackground(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, paint);
  }

  void drawText(Canvas canvas) {
    drawName(canvas);
    drawIconAndText(
      canvas,
      Icons.bolt,
      ' ${towerInfo.attackType}',
      const Offset(10, 30),
      Colors.black,
    );
    drawIconAndText(
      canvas,
      Icons.whatshot,
      ' ${towerInfo.attackDamage}',
      const Offset(70, 30),
      Colors.black,
    );
  }

  void drawName(Canvas canvas) {
    final namePainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: towerInfo.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );

    namePainter.layout();
    namePainter.paint(canvas, const Offset(10, 10));
  }

  void drawIconAndText(
    Canvas canvas,
    IconData icon,
    String text,
    Offset offset,
    Color color,
  ) {
    final iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 10,
          fontFamily: icon.fontFamily,
          color: color,
        ),
      ),
    );

    iconPainter.layout();
    iconPainter.paint(canvas, offset);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 10,
          color: color,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(canvas, offset + const Offset(14, 0));
  }
}

class TransparentTower extends GameDecoration {
  final TowerInfo towerInfo;

  TransparentTower({
    required super.position,
    required this.towerInfo,
  }) : super(size: Vector2(16, 32));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));
    loadTowerSprite();
  }

  Future<void> loadTowerSprite() async {
    final towerSprite = await Sprite.load(towerInfo.imagePath);
    add(SpriteComponent(
      sprite: towerSprite,
      size: size,
      paint: Paint()..color = Colors.white.withOpacity(0.5),
    ));
  }
}
