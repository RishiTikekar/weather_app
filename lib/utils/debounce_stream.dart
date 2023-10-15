import 'dart:async';

class DebounceStream {
  ///Debounce Duration in milliseconds
  final int milliseconds;
  // Function action;
  Timer? _timer;

  DebounceStream({
    required this.milliseconds,
  });

  run(Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
