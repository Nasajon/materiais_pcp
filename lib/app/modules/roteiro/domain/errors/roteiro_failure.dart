import 'package:flutter_core/ana_core.dart';

class RoteiroFailure extends Failure {
  RoteiroFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Roteiro',
    super.exception,
  });
}

class RemoteDatasourceRoteiroFailure extends RoteiroFailure {
  RemoteDatasourceRoteiroFailure({
    required super.errorMessage,
    required super.stackTrace,
  });
}

class IdNotFoundRoteiroFailure extends RoteiroFailure {
  IdNotFoundRoteiroFailure({
    required super.errorMessage,
    required super.stackTrace,
  });
}

class RoteiroIsNotValidFailure extends RoteiroFailure {
  RoteiroIsNotValidFailure({
    required super.errorMessage,
    required super.stackTrace,
  });
}
