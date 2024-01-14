import 'dart:async';

class Throttle {
  DateTime? _lastTimeCalled;

  final Duration minDelay;

  Throttle({
    required this.minDelay,
  });

  Future<void> call(FutureOr<void> Function() callBack) async {
    final lastTimeCalled = _lastTimeCalled;

    if (lastTimeCalled == null) return _execute(callBack);

    final millisecontsPassed = DateTime.now().difference(lastTimeCalled).inMilliseconds;

    if (millisecontsPassed > minDelay.inMilliseconds) await _execute(callBack);
  }

  FutureOr<void> _execute(FutureOr<void> Function() callBack) async {
    await callBack.call();
    _lastTimeCalled = DateTime.now();
  }
}
