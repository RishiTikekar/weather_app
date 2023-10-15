import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/global_providers/connectivity_pvd.dart';
import 'package:weatherapp/styles/styles.dart';

class OverlayWidget extends StatelessWidget {
  final Widget child;
  const OverlayWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const _ConnectivityOverlay(),
      ],
    );
  }
}

///
///it will be position on top of screen to show internet connectivity issue
class _ConnectivityOverlay extends StatelessWidget {
  const _ConnectivityOverlay();

  @override
  Widget build(BuildContext context) {
    final hasConnection = context.select<ConnectivityPvd, bool>(
      (connectivityPvd) => connectivityPvd.hasConnection,
    );
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Material(
          child: AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 200),
            color: Clr.red,
            height: hasConnection ? 0 : 25,
            alignment: Alignment.center,
            child: Text(
              "No internet connection 😢",
              style: TStyle.T_14_400_15(),
            ),
          ),
        ),
      ),
    );
  }
}
