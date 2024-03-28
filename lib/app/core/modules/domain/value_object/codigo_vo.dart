import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class CodigoVO extends ValueObject<String?> {
  CodigoVO(super.value) {
    _validate();
  }

  void _validate() {
    if (value == null || value == 0) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText => value != null ? toString() : '';
}
