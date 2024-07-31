abstract class IRepositoryException implements Exception {
  final String? label;
  final String? messageError;
  final StackTrace? stackTrace;
  IRepositoryException({this.label, this.messageError, this.stackTrace});
}

class HistoricRepositoryException extends IRepositoryException {
  HistoricRepositoryException(
      {super.label, super.messageError, super.stackTrace});
}
