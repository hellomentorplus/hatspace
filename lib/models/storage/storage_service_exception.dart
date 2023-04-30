class SaveDataFailureException implements Exception {
  final String code;
  final String? message;

  SaveDataFailureException(this.code, this.message);
}
