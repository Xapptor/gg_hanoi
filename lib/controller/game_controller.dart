import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/view/alerts.dart';
import 'package:gg_hanoi/view/game_view.dart';
import 'dart:async';

extension StateExtension on GameViewState {
  //
  //
  //
  // MARK: CHECK ROD RULES FOR MANUAL MANIPULATION
  //

  checkRodRulesAndUpdate({
    required int from,
    required int to,
  }) {
    if (widget.rods[to].disks.isNotEmpty) {
      if (widget.rods[from].disks.first.size < widget.rods[to].disks.first.size) {
        updateRods(
          from: from,
          to: to,
        );
      } else {
        showErrorAlert(context);
      }
    } else {
      updateRods(
        from: from,
        to: to,
      );
    }
  }

  //
  //
  //
  // MARK: UPDATE RODS
  //

  updateRods({
    required int from,
    required int to,
  }) {
    if (widget.rods[from].disks.isNotEmpty) {
      widget.rods[to].disks.insert(0, widget.rods[from].disks.first);
      widget.rods[from].disks.removeAt(0);

      rodSnapshots.add(widget.rods);

      currentMoves++;

      // debugPrint("Rods");
      // for (var rod in widget.rods) {
      //   int index = widget.rods.indexOf(rod);
      //   debugPrint("Rod: ${index} - Disks: ${rod.disks.length}");
      // }

      setState(() {});
    } else {
      debugPrint("rods[from].disks is Empty");
    }
  }

  //
  //
  //
  // MARK: LOCAL CALCULATION
  //

  calculateMinimumMovesLocally({
    required int numberOfDisks,
  }) {
    // This is the same as (2 ^ numberOfDisks) - 1, It is using the bitwise shift operator.
    minimumMoves = (1 << numberOfDisks) - 1;
    setState(() {});
  }

  //
  //
  //
  //  MARK: REMOTE CALCULATION
  //

  calculateMinimumMovesRemotely({
    required int numberOfDisks,
  }) {
    minimumMoves = 0;
    setState(() {});
  }

  //
  //
  //
  // MARK: AUTO SOLVE
  //

  Future<void> autoSolve() async {
    reseted.value = false;

    reset(activateBool: false);

    await Future.delayed(Duration(milliseconds: delayTime));

    stopwatch.reset();
    stopwatch.start();

    int diskCount = widget.rods.first.disks.length;

    await recursiveHanoi(
      n: diskCount,
      sourceRodIndex: 0,
      auxiliaryRodIndex: 1,
      destinationRodIndex: 2,
    );
  }

  //
  //
  //
  // MARK: RECURSIVE HANOI
  //

  Future<void> recursiveHanoi({
    required int n, // Number of disks
    required int sourceRodIndex,
    required int auxiliaryRodIndex,
    required int destinationRodIndex,
  }) async {
    if (reseted.value) return;

    if (useDebugPrint) {
      debugPrint("n: $n");
      debugPrint("SourceRodIndex: $sourceRodIndex");
      debugPrint("AuxiliaryRodIndex: $auxiliaryRodIndex");
      debugPrint("DestinationRodIndex: $destinationRodIndex");
      debugPrint("CurrentMoves: $currentMoves");
      debugPrint("----------------------------");
      debugPrint("");
    }

    // If there's only one disk, move it directly
    if (n == 1) {
      checkRodRulesAndUpdate(
        from: sourceRodIndex,
        to: destinationRodIndex,
      );

      if (currentMoves == minimumMoves) {
        stopwatch.stop();

        int elapsedMilliseconds = stopwatch.elapsedMilliseconds;
        double elapsedSeconds = elapsedMilliseconds / 1000;

        debugPrint('Algorithm completed in $elapsedMilliseconds ms');
        debugPrint('Algorithm completed in $elapsedSeconds seconds');

        // debugPrint('');
        // debugPrint("Rods:");
        // for (var rodSnap in rodSnapshots) {
        //   debugPrint("");
        //   debugPrint("Rod Snap:");

        //   for (var rod in rodSnap) {
        //     int index = rodSnap.indexOf(rod);
        //     debugPrint("Rod: ${index} - Disks: ${rod.disks.length}");
        //   }
        // }
      }

      await Future.delayed(Duration(milliseconds: delayTime));

      if (reseted.value) return;

      return;
    }

    // Move n-1 disks from source to auxiliary
    await recursiveHanoi(
      n: n - 1,
      sourceRodIndex: sourceRodIndex,
      auxiliaryRodIndex: destinationRodIndex,
      destinationRodIndex: auxiliaryRodIndex,
    );

    if (reseted.value) return;

    // Move the current largest disk on the iteration focus from source to destination
    checkRodRulesAndUpdate(
      from: sourceRodIndex,
      to: destinationRodIndex,
    );
    await Future.delayed(Duration(milliseconds: delayTime));

    if (reseted.value) return;

    // Move n-1 disks from auxiliary to destination
    await recursiveHanoi(
      n: n - 1,
      sourceRodIndex: auxiliaryRodIndex,
      auxiliaryRodIndex: sourceRodIndex,
      destinationRodIndex: destinationRodIndex,
    );
  }

  //
  //
  //
  // MARK: RESET
  //

  reset({
    bool activateBool = true,
  }) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (activateBool) {
      reseted.value = true;
    }

    widget.rods = basicRods(
      portrait: portrait,
      diskCount: originalDiskCount,
    );
    currentMoves = 0;
    setState(() {});
    showResetAlert(context);
  }
}
