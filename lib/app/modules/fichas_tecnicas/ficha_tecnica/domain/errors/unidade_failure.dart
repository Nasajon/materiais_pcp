import 'package:flutter_core/ana_core.dart';

class UnidadeFailure extends Failure {
  UnidadeFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceUnidadeFailure extends Failure {
  DatasourceUnidadeFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundUnidadeFailure extends Failure {
  IdNotFoundUnidadeFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataUnidadeFailure extends Failure {
  IncompleteOrMissingDataUnidadeFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
