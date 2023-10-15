import 'package:flutter/material.dart';
import 'package:weatherapp/styles/styles.dart';

class TextWithGradient extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? align;

  const TextWithGradient({
    super.key,
    required this.text,
    required this.style,
    this.gradient = Gradients.whiteGrad,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.modulate,
      child: Text(
        text,
        style: style,
        textAlign: align,
      ),
    );
  }
}
