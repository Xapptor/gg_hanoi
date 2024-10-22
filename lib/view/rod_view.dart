import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/view/disk_view.dart';

class RodView extends StatefulWidget {
  final Rod rod;

  const RodView({
    super.key,
    required this.rod,
  });

  @override
  State<RodView> createState() => _RodViewState();
}

class _RodViewState extends State<RodView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          color: Colors.amber,
          height: (widget.rod.maxDisks * 20) + 100,
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            widget.rod.disks.length,
            (int index) {
              return DiskView(
                disk: widget.rod.disks[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
