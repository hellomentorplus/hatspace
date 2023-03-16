class AuthenticationCancelException implements Exception {}

class UserNotFoundException implements Exception {}

class AuthenticationException implements Exception {
  final String errorCode;
  final String errorMessage;

  AuthenticationException(this.errorCode, this.errorMessage);
}
