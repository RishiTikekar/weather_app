import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherapp/styles/styles.dart';

enum ColorTheme {
  blue(Clr.blueLight, Clr.blueShimmer),
  grey(Clr.CA098AE, Color.fromRGBO(51, 51, 51, 0));

  final Color baseColor;
  final Color highlightColor;
  const ColorTheme(this.baseColor, this.highlightColor);
}

class BoxShimmer extends StatelessWidget {
  final Widget? child;
  final double height;
  final double width;
  final double? borderRadius;
  final ColorTheme theme;

  const BoxShimmer({
    super.key,
    this.child,
    required this.height,
    required this.width,
    this.theme = ColorTheme.blue,
  }) : borderRadius = null;

  const BoxShimmer.rounded({
    super.key,
    this.child,
    required this.height,
    required this.width,
    this.borderRadius = 6,
    this.theme = ColorTheme.blue,
  });

  @override
  Widget build(BuildContext context) {
    Widget shimmerWidget;

    shimmerWidget = Shimmer.fromColors(
      baseColor: theme.baseColor,
      highlightColor: theme.highlightColor,
      child: Container(
        color: Clr.white,
        height: height,
        width: width,
        child: child,
      ),
    );

    if (borderRadius != null) {
      shimmerWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: shimmerWidget,
      );
    }

    return shimmerWidget;
  }
}
