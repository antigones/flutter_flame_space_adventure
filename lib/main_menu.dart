import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/space_shooter_game.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Space Adventure',
              style: TextStyle(fontFamily: 'Fipps', color: Color(0xFFFFCD75), fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const Text(
              'An adventure of spaceships, captains and asteroids',
              style: TextStyle(fontFamily: 'Fipps', color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 20,
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GameWidget(game: SpaceShooterGame()))
                );
              },
              label: const Text(
                'Start game',
                  style: TextStyle(fontFamily: 'Fipps', color: Color(0xFF5D275D))
                //style: TextStyle(color: Color(0xFF5D275D)),
              ),
              width:250,
              height: 75,
            ),
          )],
        ),
      ),
    );
  }
}
