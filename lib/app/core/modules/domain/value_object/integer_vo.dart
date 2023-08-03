import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class IntegerVO extends ValueObject<int?> {
  IntegerVO(super.value) {
    _validate();
  }

  factory IntegerVO.text(String value) {
    try {
      return IntegerVO(int.parse(value));
    } on FormatException catch (e) {
      return IntegerVO(0);
    }
  }

  void _validate() {
    if (value == null || (value != null && value! <= 0)) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText => value != null ? toString() : '';
}
