abstract interface class SessionManager {
  String get token;
}

class MockedSessionManager implements SessionManager {
  @override
  String get token {
    return const String.fromEnvironment('USER_TOKEN');
  }
}
