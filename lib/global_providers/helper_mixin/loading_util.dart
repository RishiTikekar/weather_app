import 'package:flutter/material.dart';

mixin LoadingUtil on ChangeNotifier {
  bool get hasData;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
