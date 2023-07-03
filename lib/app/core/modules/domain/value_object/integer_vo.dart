import 'package:pcp_flutter/app/core/constants/app_localization.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class IntegerVO extends ValueObject<int?> {
  IntegerVO(super.value) {
    _validade();
  }

  factory IntegerVO.text(String value) {
    try {
      return IntegerVO(int.parse(value));
    } on FormatException catch (e) {
      return IntegerVO(0);
    }
  }

  void _validade() {
    if (value == null || (value != null && value! <= 0)) {
      errorMessage = AppLocalization.l10n.messages.errorCampoObrigatorio;
    }
  }

  String get toText => value != null ? toString() : '';
}
