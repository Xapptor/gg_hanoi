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
      children: <Widget>[
        Container(
          color: Colors.deepPurpleAccent,
          height: 200,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            widget.rod.disks.length,
            (index) {
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
