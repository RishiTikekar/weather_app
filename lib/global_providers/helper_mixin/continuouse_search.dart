import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/utils/debounce_stream.dart';
import 'package:weatherapp/utils/util_fun.dart';

mixin ContinuousSearch on ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  DebounceStream streamDebounce = DebounceStream(milliseconds: 500);

  Stream<String>? searchStream;
  StreamController<String>? streamController;
  String? previousSearch;

  Future onSearch(String searchData);

  bool isValidSearch(String searchText) =>
      UtilFun.isValidString(searchText) &&
      searchText.length >= 3 &&
      previousSearch != searchText;

  void listenTextCtrl() {
    streamController = StreamController.broadcast();

    searchStream = streamController?.stream;

    searchStream?.listen((String searchData) {
      streamDebounce.run(() => onSearch(searchData));
    });

    searchCtrl.addListener(() {
      String searchText = searchCtrl.text.trim();
      if (isValidSearch(searchText)) {
        previousSearch = searchText;
        streamController?.add(searchText);
      }
    });
  }

  @override
  void dispose() {
    searchCtrl.removeListener(() {});
    searchCtrl.dispose();
    streamController?.close();
    super.dispose();
  }
}
