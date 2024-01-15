import 'dart:io';

/// A mixin for Flutter widgets to facilitate testing scenarios.
///
/// The `TestMixin` provides a way to check whether the code is running in a
/// testing environment. It is particularly useful when testing widgets that
/// involve animations, such as `CircularProgressIndicator`, where the animation
/// might interfere with test execution.
mixin TestMixin on Object {
  bool get isTesting => Platform.environment.containsKey('FLUTTER_TEST');
}
