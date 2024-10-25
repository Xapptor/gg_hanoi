import 'package:flutter/material.dart';
import 'package:gg_hanoi/controller/game_controller.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/values.dart';
import 'package:gg_hanoi/view/rod_view.dart';

class GameView extends StatefulWidget {
  final String title;
  List<Rod> rods;

  GameView({
    super.key,
    required this.title,
    required this.rods,
  });

  @override
  State<GameView> createState() => GameViewState();
}

class GameViewState extends State<GameView> {
  Stopwatch stopwatch = Stopwatch();

  int originalDiskCount = 0;
  int minimumMoves = 0;
  int currentMoves = 0;

  static bool useSlowDelayTime = true;
  bool useDebugPrint = true;

  int delayTime = useSlowDelayTime ? (2 * 2000) : 0;

  ValueNotifier<bool> reseted = ValueNotifier<bool>(false);

  final ScrollController _scrollController = ScrollController();

  List<List<Rod>> rodSnapshots = [];

  @override
  void initState() {
    originalDiskCount = widget.rods.first.maxDisks;

    super.initState();

    calculateMinimumMovesLocally(
      numberOfDisks: widget.rods.first.maxDisks,
    );
    // _calculateMinimumMovesRemotely(
    //   numberOfDisks: widget.rods.first.maxDisks,
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: coolGameDarkBackgroundColor,
        child: SingleChildScrollView(
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
              customSpacer(multiplier: 2),
              Text(
                'Minimum of Moves: $minimumMoves',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              customSpacer(),
              Text(
                'Current Moves: $currentMoves',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              customSpacer(multiplier: 3),
              SizedBox(
                height: widget.rods.first.maxDisks * baseDiskSize(portrait: portrait) +
                    MediaQuery.of(context).size.height * 0.3,
                child: RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thumbColor: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemExtent: widget.rods.first.maxDisks * baseDiskSize(portrait: portrait) + 64,
                    primary: false,
                    children: List.generate(
                      widget.rods.length,
                      (int index) {
                        return RodView(
                          rod: widget.rods[index],
                          index: index,
                          updateRods: checkRodRulesAndUpdate,
                          reseted: reseted,
                        );
                      },
                    ),
                  ),
                ),
              ),
              customSpacer(multiplier: 3),
              ElevatedButton(
                onPressed: () {
                  autoSolve();
                },
                child: const Text('Auto-Solve'),
              ),
              customSpacer(),
              ElevatedButton(
                onPressed: () {
                  reset();
                },
                child: const Text('Reset'),
              ),
              customSpacer(multiplier: 3),
            ],
          ),
        ),
      ),
    );
  }
}
