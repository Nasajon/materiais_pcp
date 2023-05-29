import 'package:flutter_core/ana_core.dart';

class GrupoDeRestricaoNoInternetConnection extends Failure {
  GrupoDeRestricaoNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class GrupoDeRestricaoInvalidIdError extends Failure {
  GrupoDeRestricaoInvalidIdError() : super(errorMessage: 'Invalid id text error');
}

class GrupoDeRestricaoNotFound extends Failure {}
