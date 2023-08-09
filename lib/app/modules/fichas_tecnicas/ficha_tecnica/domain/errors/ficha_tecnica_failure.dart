import 'package:flutter_core/ana_core.dart';

class FichaTecnicaFailure extends Failure {
  FichaTecnicaFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceFichaTecnicaFailure extends FichaTecnicaFailure {
  DatasourceFichaTecnicaFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundFichaTecnicaFailure extends FichaTecnicaFailure {
  IdNotFoundFichaTecnicaFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataFichaTecnicaFailure extends FichaTecnicaFailure {
  IncompleteOrMissingDataFichaTecnicaFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
