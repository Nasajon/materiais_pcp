import 'package:flutter_core/ana_core.dart';

class TurnoTrabalhoFailure extends Failure {
  TurnoTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Turno de Trabalho',
    super.exception,
  });
}

class DatasourceTurnoTrabalhoFailure extends Failure {
  DatasourceTurnoTrabalhoFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class TurnoTrabalhoIsNotValidFailure extends Failure {
  TurnoTrabalhoIsNotValidFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundTurnoTrabalhoFailure extends Failure {
  IdNotFoundTurnoTrabalhoFailure({
    super.errorMessage = 'ID não encontrado. Verifique se o ID fornecido é válido.',
    super.stackTrace,
    super.exception,
  });
}
