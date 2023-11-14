import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';

class RestricaoFailure extends Failure {
  RestricaoFailure({
    super.errorMessage,
    super.stackTrace,
  }) : super(label: translation.titles.restricoesSecundarias);
}

class DatasourceRestricaoFailure extends RestricaoFailure {
  DatasourceRestricaoFailure({
    super.errorMessage,
    super.stackTrace,
  });
}
