import 'package:flutter_core/ana_core.dart';

class RecursoFailure extends Failure {
  RecursoFailure({
    super.errorMessage,
    super.stackTrace,
  });
}

class DatasourceRecursoFailure extends RecursoFailure {
  DatasourceRecursoFailure({
    super.errorMessage,
    super.stackTrace,
  });
}

class RecursoNoInternetConnection extends Failure {
  RecursoNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class RecursoInvalidIdError extends Failure {
  RecursoInvalidIdError() : super(errorMessage: 'Invalid id text error');
}

class RecursoInvalidCentroDeTrabalhoIdError extends RecursoFailure {
  RecursoInvalidCentroDeTrabalhoIdError({super.errorMessage, super.stackTrace});
}

class RecursoNotFound extends Failure {}
