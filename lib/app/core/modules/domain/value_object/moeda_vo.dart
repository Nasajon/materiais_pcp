import 'package:pcp_flutter/app/core/constants/app_localization.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class MoedaVO extends ValueObject<double> {
  MoedaVO(super.value) {
    _validade();
  }

  factory MoedaVO.text(String value) {
    try {
      return MoedaVO(double.parse(value));
    } on FormatException catch (_) {
      return MoedaVO(0);
    }
  }

  void _validade() {
    if (value <= 0) {
      errorMessage = AppLocalization.l10n.messages.errorCampoObrigatorio;
    }
  }

  String get toText => toString();
}