class BaseException implements Exception {
  final String? label;
  final String? messageError;
  final StackTrace? stackTrace;

  BaseException({this.label, this.messageError, this.stackTrace});
}
