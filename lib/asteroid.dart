import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_game/player.dart';
import 'package:flutter_game/space_shooter_game.dart';

import 'main.dart';

class Asteroid extends SpriteComponent with HasGameRef<SpaceShooterGame>, HasHitboxes, Collidable {
  bool _isWallHit = false;
  bool _isPlayerHit = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var rng = Random();
    sprite = await gameRef.loadSprite('asteroid.png');
    position.x = 75 + rng.nextInt(gameRef.viewportResolution.x.round() - 150).toDouble();
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
      if (gameRef.score > 0) {
        gameRef.score -= 100;
      }
      _isWallHit = false;
      return;
    }

    if (_isPlayerHit) {
      removeFromParent();
      _isPlayerHit = false;
      gameRef.score = 0;
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

    if (other is Player) {
      // asteroid hit the player
      _isPlayerHit = true;
      print('asteroid hit the player');
      return;
    }
  }
}
