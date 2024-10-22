import 'dart:ui';
import 'package:gg_hanoi/model/disk.dart';

class Rod {
  final Color color;
  List<Disk> disks;

  Rod({
    required this.color,
    required this.disks,
  });
}
