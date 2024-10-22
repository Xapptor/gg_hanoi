import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/view/disk_view.dart';

class RodView extends StatelessWidget {
  final Rod rod;
  final int index;
  final Function({
    required int from,
    required int to,
  }) updateRods;

  const RodView({
    super.key,
    required this.rod,
    required this.index,
    required this.updateRods,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context, candidateItems, rejectedItems) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              color: Colors.amber,
              height: (rod.maxDisks * 20) + 100,
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                rod.disks.length,
                (int diskIndex) {
                  return DiskView(
                    disk: rod.disks[diskIndex],
                    index: diskIndex,
                    rodIndex: index,
                  );
                },
              ),
            ),
          ],
        );
      },
      onAcceptWithDetails: (diskIndex) {
        updateRods(
          from: diskIndex.data,
          to: index,
        );
      },
    );
  }
}
