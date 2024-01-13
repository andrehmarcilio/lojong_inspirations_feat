import 'dart:async';

/// Represents an Either type that can hold either a success value [R] or a failure value [L].
abstract class Either<L, R> {
  /// Returns `true` if this Either is a success.
  bool get isSuccess => this is Success<L, R>;

  /// Returns `true` if this Either is a failure.
  bool get isFailure => this is Failure<L, R>;

  /// Returns the success data if this Either is a success.
  R get successData {
    assert(isSuccess, 'Cannot get success value from a Failure Either');
    return (this as Success<L, R>)._success;
  }

  /// Returns the failure data if this Either is a failure.
  L get failureData {
    assert(isFailure, 'Cannot get failure value from a Success Either');
    return (this as Failure<L, R>)._failure;
  }

  /// Performs conditional actions based on whether this Either is a success or failure.
  ///
  /// If this Either is a success, the [success] callback is called.
  /// If this Either is a failure, the [failure] callback is called.
  FutureOr<void> fold({
    FutureOr<void> Function(L)? failure,
    FutureOr<void> Function(R)? success,
  }) async {
    if (isSuccess) {
      await success?.call(successData);
    } else {
      await failure?.call(failureData);
    }
  }
}

/// Represents a success variant of the Either type holding a success value [R].
class Success<L, R> extends Either<L, R> {
  final R _success;

  /// Creates a Success Either with the provided success value.
  Success(this._success);
}

/// Represents a failure variant of the Either type holding a failure value [L].
class Failure<L, R> extends Either<L, R> {
  final L _failure;

  /// Creates a Failure Either with the provided failure value.
  Failure(this._failure);
}
