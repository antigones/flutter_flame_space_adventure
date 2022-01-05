import 'package:flame/game.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/space_shooter_game.dart';

Widget endMenuBuilder(BuildContext context, SpaceShooterGame game) {
  return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game over!',
                style: TextStyle(
                    fontFamily: 'Fipps', color: Color(0xFFFFCD75), fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your score: '+ game.score.toString(),
                style: const TextStyle(
                    fontFamily: 'Fipps', color: Color(0xFFFFCD75), fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Container(
                color: Colors.black,
                width: 250,
                height: 75,
                padding: const EdgeInsets.all(20),
                child: SpriteButton.asset(
                  path: 'buttons.png',
                  pressedPath: 'buttons.png',
                  srcPosition: Vector2(0, 0),
                  srcSize: Vector2(60, 20),
                  pressedSrcPosition: Vector2(0, 20),
                  pressedSrcSize: Vector2(60, 20),
                  onPressed: () {
                    game.overlays.remove('EndMenu');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => GameWidget(
                          game: SpaceShooterGame(),
                          overlayBuilderMap: const {
                            'EndMenu': endMenuBuilder,
                          },
                        )));
                  },
                  label: const Text('Start a new game',
                      style: TextStyle(
                          fontFamily: 'Fipps', color: Color(0xFF5D275D))),
                  width: 250,
                  height: 75,
                ),
              )
            ],
          )));
}