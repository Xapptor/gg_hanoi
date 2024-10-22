import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/disk.dart';

class DiskView extends StatelessWidget {
  final Disk disk;
  final int index;
  final int rodIndex;

  const DiskView({
    super.key,
    required this.disk,
    required this.index,
    required this.rodIndex,
  });

  @override
  Widget build(BuildContext context) {
    Widget diskWidget = Container(
      height: 20,
      width: disk.size,
      decoration: BoxDecoration(
        color: disk.color,
        borderRadius: BorderRadius.circular(4),
      ),
    );

    return index == 0
        ? Draggable<int>(
            data: rodIndex,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: diskWidget,
            child: diskWidget,
          )
        : diskWidget;
  }
}
