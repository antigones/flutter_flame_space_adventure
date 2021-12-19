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
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isWallHit = false;
  bool _isCollision = false;

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

  /*void move(Vector2 delta) {
    position.add(delta);
  }*/

  @override
  void update(double dt) {
    if (_isWallHit) {
      //removeFromParent();
      position.x = gameRef.size.x/2;
      position.y = gameRef.size.y-20;
      _isWallHit = false;
      return;
    }
    debugColor = _isCollision ? _collisionColor : _defaultColor;
    _isCollision = false;
  }
/*
  @override
  void render(Canvas canvas) {
    renderHitboxes(canvas);
  }*/

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      _isWallHit = true;
      print('wallhit');
      return;
    }
    if (other is Asteroid) {
      print('asteroid hit');
    }
    _isCollision = true;

  }

}