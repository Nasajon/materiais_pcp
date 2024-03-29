import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';

class GrupoDeRestricaoNoInternetConnection extends Failure {
  GrupoDeRestricaoNoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class GrupoDeRestricaoInvalidIdError extends Failure {
  GrupoDeRestricaoInvalidIdError() : super(errorMessage: translation.messages.erroIdNaoInformado);
}

class GrupoDeRestricaoNotFound extends Failure {}
