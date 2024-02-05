import 'dart:async';

import 'package:async/async.dart';

class EventTimer<T> {
  Timer? _debounce;

  Future<T?> timer(
    Future<T> Function() func, {
    Duration delay = const Duration(
      milliseconds: 300,
    ),
  }) async {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      func.call();
    });

    return null;
  }
}

class _MutableObjects<T> {
  T? value;
  CancelableOperation? completerExecution;
  DateTime lastExecution = DateTime.now();
}
