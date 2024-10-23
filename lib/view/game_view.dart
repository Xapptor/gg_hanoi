import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/values.dart';
import 'package:gg_hanoi/view/alerts.dart';
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
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int originalDiskCount = 0;
  int minimumMoves = 0;
  int currentMoves = 0;

  _checkRodRules({
    required int from,
    required int to,
  }) {
    if (widget.rods[to].disks.isNotEmpty) {
      if (widget.rods[from].disks.first.size < widget.rods[to].disks.first.size) {
        _updateRods(
          from: from,
          to: to,
        );
      } else {
        showErrorAlert(context);
      }
    } else {
      _updateRods(
        from: from,
        to: to,
      );
    }
  }

  _updateRods({
    required int from,
    required int to,
  }) {
    widget.rods[to].disks.insert(0, widget.rods[from].disks.first);
    widget.rods[from].disks.removeAt(0);
    currentMoves++;

    // debugPrint("Rods");
    // for (var rod in widget.rods) {
    //   int index = widget.rods.indexOf(rod);
    //   debugPrint("Rod: ${index} - Disks: ${rod.disks.length}");
    // }

    setState(() {});
  }

  _calculateMinimumMovesLocally({
    required int numberOfDisks,
  }) {
    minimumMoves = (1 << numberOfDisks) - 1;
    setState(() {});
  }

  _calculateMinimumMovesRemotely({
    required int numberOfDisks,
  }) {
    minimumMoves = 0;
    setState(() {});
  }

  _autoSolve() {
    debugPrint('Auto-Solve');
  }

  _reset() {
    widget.rods = basicRods(diskCount: originalDiskCount);
    currentMoves = 0;
    setState(() {});
    showResetAlert(context);
  }

  @override
  void initState() {
    originalDiskCount = widget.rods.first.maxDisks;
    super.initState();
    _calculateMinimumMovesLocally(
      numberOfDisks: widget.rods.first.maxDisks,
    );
    // _calculateMinimumMovesRemotely(
    //   numberOfDisks: widget.rods.first.maxDisks,
    // );
  }

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
              width: MediaQuery.of(context).size.width * (portrait ? 0.8 : 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  widget.rods.length,
                  (int index) {
                    return RodView(
                      rod: widget.rods[index],
                      index: index,
                      updateRods: _checkRodRules,
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
            customSpacer(multiplier: 3),
            ElevatedButton(
              onPressed: () {
                _autoSolve();
              },
              child: const Text('Auto-Solve'),
            ),
            customSpacer(),
            ElevatedButton(
              onPressed: () {
                _reset();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
