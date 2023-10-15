import 'package:flutter/material.dart';

enum LocalType {
  english('en', 'English'),
  marathi('mr', 'मराठी');

  final String locale;
  final String displayName;
  const LocalType(this.locale, this.displayName);
}

class LocalePvd with ChangeNotifier {
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  LocalType selectedLocale = LocalType.english;

  void selectLocate(LocalType type) {
    selectedLocale = type;
    notifyListeners();
  }
}
