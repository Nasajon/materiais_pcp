import 'package:flutter_core/ana_core.dart';

class UnidadeFailure extends Failure {
  UnidadeFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceUnidadeFailure extends UnidadeFailure {
  DatasourceUnidadeFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundUnidadeFailure extends UnidadeFailure {
  IdNotFoundUnidadeFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataUnidadeFailure extends UnidadeFailure {
  IncompleteOrMissingDataUnidadeFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
