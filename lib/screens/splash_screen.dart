import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/text_with_gradient.dart';
import 'package:weatherapp/styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Gradients.blueGrad),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.icCloudy, height: 118, width: 120),
              Text(
                L.of(context)!.cloudy,
                style: TStyle.T_34_700_15(),
              ),
              const SizedBox(height: 10),
              TextWithGradient(
                text: L.of(context)!.splash_subtitle,
                style: TStyle.T_16_400_15(),
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
