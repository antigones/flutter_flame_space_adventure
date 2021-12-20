import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_game/asteroid.dart';
import 'package:flutter_game/space_shooter_game.dart';

import 'main.dart';

class Shoot extends SpriteComponent with HasGameRef<SpaceShooterGame>, HasHitboxes, Collidable {
  bool _isWallHit = false;
  bool _isCollision = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var rng = Random();
    sprite = await gameRef.loadSprite('fire.png');

    position.x = gameRef.player.position.x;
    position.y = gameRef.player.position.y -   80;
    width = 50;
    height = 50;
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
    position.y -= 10;
    if (_isWallHit || _isCollision) {
      removeFromParent();
      _isCollision = false;
      _isWallHit = false;
      return;
    }

  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      _isWallHit = true;
      print('shoot wallhit');
      removeFromParent();
      return;
    }

    if (other is Asteroid) {
      _isCollision = true;
      print('asteroid shoot');
      other.removeFromParent();
      removeFromParent();

      gameRef.score += 100;


      return;
    }


  }
}