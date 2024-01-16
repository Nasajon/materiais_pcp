import 'package:flutter_core/ana_core.dart';

class GrupoDeRecursosNoInternetConnection extends Failure {
  GrupoDeRecursosNoInternetConnection()
      : super(errorMessage: 'No Internet Connection');
}

class GrupoDeRecursosInvalidIdError extends Failure {
  GrupoDeRecursosInvalidIdError()
      : super(errorMessage: 'Invalid id text error');
}

class GrupoDeRecursoNotFound extends Failure {}
