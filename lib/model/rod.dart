import 'package:gg_hanoi/model/disk.dart';
import 'package:gg_hanoi/values.dart';

class Rod {
  List<Disk> disks;
  final int maxDisks;

  Rod({
    required this.disks,
    required this.maxDisks,
  });
}

List<Rod> basicRods({
  int diskCount = 3,
}) {
  return [
    Rod(
      disks: List.generate(
        diskCount,
        (index) {
          return Disk(
            color: getRandomColor(),
            size: (index + 1) * baseDiskSize,
          );
        },
      ),
      maxDisks: diskCount,
    ),
    Rod(
      disks: [],
      maxDisks: diskCount,
    ),
    Rod(
      disks: [],
      maxDisks: diskCount,
    ),
  ];
}
