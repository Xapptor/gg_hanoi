import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gg_hanoi/extensions.dart';

Widget customSpacer({
  double multiplier = 1,
}) =>
    SizedBox(
      height: 24 * multiplier,
    );

Color getRandomColor() => ColorExtension.fromHex('#${Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0')}');

double baseDiskSize({
  required bool portrait,
}) =>
    portrait ? 11 : 22;

Color coolGameDarkBackgroundColor = ColorExtension.fromHex('#1A1A1A');
