import 'package:flutter_core/ana_core.dart';

class CentroTrabalhoFailure extends Failure {
  CentroTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Centro de Trabalho',
    super.exception,
  });
}

class DatasourceCentroTrabalhoFailure extends CentroTrabalhoFailure {
  DatasourceCentroTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class CentroTrabalhoIsNotValidFailure extends CentroTrabalhoFailure {
  CentroTrabalhoIsNotValidFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundCentroTrabalhoFailure extends CentroTrabalhoFailure {
  IdNotFoundCentroTrabalhoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataCentroTrabalhoFailure extends CentroTrabalhoFailure {
  IncompleteOrMissingDataCentroTrabalhoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
