import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPvd with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool hasConnection = true;
  late StreamSubscription<ConnectivityResult> connectivityStream;

  ConnectivityPvd() {
    checkInitialConnection();
    connectivityStream = _connectivity.onConnectivityChanged.listen(
      onConnectionChange,
    );
  }

  void onConnectionChange(ConnectivityResult result) {
    final isConnected = result != ConnectivityResult.none;

    if (isConnected != hasConnection) {
      hasConnection = isConnected;
      notifyListeners();
    }
  }

  Future<void> checkInitialConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();

    final isConnected = result != ConnectivityResult.none;
    if (isConnected != hasConnection) {
      hasConnection = isConnected;
      notifyListeners();
    }
  }
}
