import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/values.dart';
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
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: coolGameDarkBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            customSpacer(),
            const Text(
              'Moves: 0',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            customSpacer(multiplier: 3),
            SizedBox(
              width: MediaQuery.of(context).size.width * (portrait ? 0.8 : 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  widget.rods.length,
                  (int index) {
                    return RodView(
                      rod: widget.rods[index],
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey,
              height: 20,
              width: MediaQuery.of(context).size.width * (portrait ? 0.8 : 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
