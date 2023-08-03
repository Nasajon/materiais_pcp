import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class CodigoVO extends ValueObject<int?> {
  CodigoVO(super.value) {
    _validate();
  }

  factory CodigoVO.text(String value) {
    try {
      return CodigoVO(int.parse(value));
    } on FormatException catch (e) {
      return CodigoVO(0);
    }
  }

  void _validate() {
    if (value == null || value == 0) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText => value != null ? toString() : '';
}
