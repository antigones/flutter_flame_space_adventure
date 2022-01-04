import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_game/space_shooter_game.dart';

import 'main.dart';

class Asteroid extends SpriteComponent with HasGameRef<SpaceShooterGame>, HasHitboxes, Collidable {
  bool _isWallHit = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var rng = Random();
    sprite = await gameRef.loadSprite('asteroid.png');
    position.x = 75 + rng.nextInt(gameRef.viewportResolution.x.round() - 80).toDouble();
    position.y = 40;
    width = 71;
    height = 71;
    anchor = Anchor.center;

    final shape = HitboxPolygon([
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(-1, 0),
    ]);
    addHitbox(shape);
  }

  @override
  void update(double dt) {
    position.y += 10;
    if (_isWallHit) {
      removeFromParent();
      _isWallHit = false;
      return;
    }
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      _isWallHit = true;
      print('asteroid wallhit');
      return;
    }
  }
}
