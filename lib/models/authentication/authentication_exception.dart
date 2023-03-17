class UserNotFoundException implements Exception {}

class UserCancelException implements Exception {}

class AuthenticationException implements Exception {
  final String code;
  final String? message;

  AuthenticationException(this.code, this.message);
}

class UnknownException implements Exception {
  final StackTrace stackTrace;

  UnknownException(this.stackTrace);
}
