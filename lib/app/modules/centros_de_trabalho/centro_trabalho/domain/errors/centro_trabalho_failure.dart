import 'package:flutter_core/ana_core.dart';

class CentroTrabalhoFailure extends Failure {
  CentroTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Centro de Trabalho',
    super.exception,
  });
}

class DatasourceCentroTrabalhoFailure extends Failure {
  DatasourceCentroTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundCentroTrabalhoFailure extends Failure {
  IdNotFoundCentroTrabalhoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataCentroTrabalhoFailure extends Failure {
  IncompleteOrMissingDataCentroTrabalhoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
