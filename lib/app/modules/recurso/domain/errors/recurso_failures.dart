import 'package:flutter_core/ana_core.dart';

class RecursoNoInternetConnection extends Failure {
  RecursoNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class RecursoInvalidIdError extends Failure {
  RecursoInvalidIdError() : super(errorMessage: 'Invalid id text error');
}

class RecursoNotFound extends Failure {}
