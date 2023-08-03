import 'package:flutter_core/ana_core.dart';

class RoteiroFailure extends Failure {
  RoteiroFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Roteiro',
    super.exception,
  });
}

class IdNotFoundRoteiroFailure extends Failure {
  IdNotFoundRoteiroFailure({
    required super.errorMessage,
    required super.stackTrace,
  });
}
