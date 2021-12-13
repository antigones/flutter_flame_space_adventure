import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/player.dart';
import 'dart:math';
import 'dart:async' as asy;

import 'asteroid.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, KeyboardEvents, HasCollidables {
  late Player player;
  late Asteroid asteroid;
  late Timer timer;


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    player = Player();
    add(player);
    add(ScreenCollidable());

    final asy.Timer timer = asy.Timer.periodic(const Duration(seconds: 1), (timer) {
      asteroid = Asteroid();
      add(asteroid);
    });
  }

  /*@override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
  */


  @override
  KeyEventResult onKeyEvent(RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (isArrowLeft) {
      player.position.x -= 30;
      return KeyEventResult.handled;
    }
    if (isArrowRight) {
      player.position.x += 30;
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}