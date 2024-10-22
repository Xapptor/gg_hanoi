import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/disk.dart';

class DiskView extends StatefulWidget {
  final Disk disk;

  const DiskView({
    super.key,
    required this.disk,
  });

  @override
  State<DiskView> createState() => _DiskViewState();
}

class _DiskViewState extends State<DiskView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: widget.disk.size,
      decoration: BoxDecoration(
        color: widget.disk.color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
