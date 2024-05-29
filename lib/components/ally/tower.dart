import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/projectile.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/widgets/buttons/tower_info_button.dart';

abstract class Tower extends SimpleAlly with TapGesture {
  final String imagePath;

  final TowerType type;
  final int attackInterval;
  final double visionRange;
  final double attackDamage;
  double lastAttackTime = 0;

  TowerInfoPanel? towerInfoPanel;

  Tower({
    required this.type,
    required this.attackDamage,
    required super.position,
    required super.size,
    required this.attackInterval,
    required this.visionRange,
    required this.imagePath,
  }) : super(
          initDirection: Direction.down,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await loadTowerSprite();
  }

  Future<void> loadTowerSprite() async {
    final towerSprite = await Sprite.load(imagePath);
    add(SpriteComponent(
      sprite: towerSprite,
      size: size,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldAttack(dt)) {
      performAttack();
    }
  }

  bool shouldAttack(double dt) {
    lastAttackTime += dt * 1000;
    if (lastAttackTime >= attackInterval) {
      lastAttackTime = 0;
      return true;
    }
    return false;
  }

  void performAttack() {
    seeComponentType<Enemy>(
      radiusVision: visionRange,
      observed: (enemies) {
        if (enemies.isNotEmpty) {
          executeAttack(enemies);
        }
      },
    );
  }

  void executeAttack(List<Enemy> enemies);

  void executeDamage(Enemy enemy) {
    if (enemy.life > 0 && !enemy.isRemoved) {
      enemy.receiveDamage(
        AttackFromEnum.PLAYER_OR_ALLY,
        attackDamage,
        null,
      );
    }
  }

  void launchProjectile(List<Enemy> enemies) {
    for (var enemy in enemies) {
      final projectile = Projectile(
        position: position.clone(),
        target: enemy.position,
        damage: attackDamage,
        speed: 200,
        onHit: () {
          executeDamage(enemy);
        },
      );
      gameRef.add(projectile);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTap() {
    if (towerInfoPanel == null) {
      towerInfoPanel =
          TowerInfoPanel(tower: this, position: position + Vector2(0, 16));
      gameRef.add(towerInfoPanel!);
    } else {
      // 이미 활성화된 경우 제거
      towerInfoPanel?.removeButtons();
      towerInfoPanel?.removeFromParent();
      towerInfoPanel = null;
    }
  }

  // 배경을 클릭했을 때 버튼 제거
  void handleBackgroundTap() {
    if (towerInfoPanel != null) {
      if (!towerInfoPanel!.anyButtonTapped()) {
        towerInfoPanel?.removeButtons();
        towerInfoPanel?.removeFromParent();
        towerInfoPanel = null;
      } else {
        for (var button in towerInfoPanel!.buttons) {
          button.isTapped = false;
        }
      }
    }
  }
}
