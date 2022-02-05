import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({this.milliseconds = 700});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
