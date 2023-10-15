import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weatherapp/styles/colors.dart';

class Gradients {
  static const Gradient blueGrad = LinearGradient(
    colors: [Clr.blue, Clr.blueLight],
    begin: Alignment(0.5, 0),
    end: Alignment(0.5, 1),
  );

  static const Gradient cardBlueGrad = LinearGradient(
    colors: [Clr.blue, Clr.blueLight],
    stops: [0, 1],
    begin: Alignment(0.5, 0),
    end: Alignment(0.5, 1),
    transform: GradientRotation(pi),
  );

  static const Gradient whiteGrad = LinearGradient(
    colors: [Clr.white, Clr.white0],
    transform: GradientRotation(258 * pi / 180),
  );
}
