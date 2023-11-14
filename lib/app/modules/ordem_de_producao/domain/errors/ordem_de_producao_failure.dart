import 'package:flutter_core/ana_core.dart';

class OrdemDeProducaoFailure extends Failure {
  OrdemDeProducaoFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}

class DatasourceOrdemDeProducaoFailure extends OrdemDeProducaoFailure {
  DatasourceOrdemDeProducaoFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}

class InvalidOrdemDeProducaoFailure extends OrdemDeProducaoFailure {
  InvalidOrdemDeProducaoFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}

class IdNotFoundOrdemDeProducaoFailure extends OrdemDeProducaoFailure {
  IdNotFoundOrdemDeProducaoFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}
