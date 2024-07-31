import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/database_exception.dart';

abstract class IDatabase {
  bool get isOpen => false;

  Future<void> open({covariant IDatabaseParam? param});
  Future<Either<IDatabaseException, CustomResponseDb<T>>> get<T>(
      {required covariant IDatabaseParam param});
  Future<Either<IDatabaseException, Unit>> create(
      {required covariant IDatabaseParam param});
  Future<Either<IDatabaseException, Unit>> delete(
      {required covariant IDatabaseParam param});
  Future<Either<IDatabaseException, Unit>> update(
      {required covariant IDatabaseParam param});
  Future<void> close();
}

abstract class IDatabaseParam {}

class CustomResponseDb<T> {
  final T data;

  CustomResponseDb({required this.data});
}
