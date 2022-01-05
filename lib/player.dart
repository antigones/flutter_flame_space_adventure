import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/asteroid.dart';
import 'package:flutter_game/space_shooter_game.dart';

import 'main.dart';

class Player extends SpriteComponent with HasGameRef<SpaceShooterGame>, HasHitboxes, Collidable {
  // HasGameRef, adds gameRef var, pointing to current FlameGame
  // SpriteComponent, a game component with Sprites
  bool _isWallHit = false;


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('spaceship.png');

    position.x = gameRef.size.x/2;
    position.y = gameRef.size.y-20;
    width = 100;
    height = 100;
    anchor = Anchor.bottomCenter;

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
    if (_isWallHit) {
      position.x = gameRef.size.x/2;
      position.y = gameRef.size.y-20;
      _isWallHit = false;
      return;
    }

  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      _isWallHit = true;
      print('wallhit');
      return;
    }



  }

}