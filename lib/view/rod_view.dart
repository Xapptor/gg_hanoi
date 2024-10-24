import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/values.dart';
import 'package:gg_hanoi/view/disk_view.dart';

class RodView extends StatelessWidget {
  final Rod rod;
  final int index;
  final Function({
    required int from,
    required int to,
  }) updateRods;
  final ValueNotifier<bool> reseted;

  const RodView({
    super.key,
    required this.rod,
    required this.index,
    required this.updateRods,
    required this.reseted,
  });

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return DragTarget<int>(
      builder: (context, candidateItems, rejectedItems) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  color: Colors.amber,
                  height: (rod.maxDisks * 20) + 100,
                  width: baseDiskSize(
                        portrait: portrait,
                      ) -
                      4,
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
            ),
            customSpacer(),
            Text(
              'Rod ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        );
      },
      onAcceptWithDetails: (diskIndex) {
        reseted.value = false;

        updateRods(
          from: diskIndex.data,
          to: index,
        );
      },
    );
  }
}
