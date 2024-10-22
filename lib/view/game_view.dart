import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/view/rod_view.dart';

class GameView extends StatefulWidget {
  final String title;
  final List<Rod> rods;

  const GameView({
    super.key,
    required this.title,
    required this.rods,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListView.builder(
              itemCount: widget.rods.length,
              itemBuilder: (BuildContext context, int index) {
                return RodView(
                  rod: widget.rods[index],
                );
              },
            ),
          ],
        ),
        Container(
          color: Colors.deepPurpleAccent,
          width: 200,
        ),
      ],
    );
  }
}
