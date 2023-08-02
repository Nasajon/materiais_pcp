import 'package:flutter_core/ana_core.dart';

class FichaTecnicaFailure extends Failure {
  FichaTecnicaFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceFichaTecnicaFailure extends Failure {
  DatasourceFichaTecnicaFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundFichaTecnicaFailure extends Failure {
  IdNotFoundFichaTecnicaFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataFichaTecnicaFailure extends Failure {
  IncompleteOrMissingDataFichaTecnicaFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
