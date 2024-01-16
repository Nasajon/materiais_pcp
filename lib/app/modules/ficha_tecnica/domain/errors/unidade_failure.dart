import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';

class UnidadeFailure extends FichaTecnicaFailure {
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
