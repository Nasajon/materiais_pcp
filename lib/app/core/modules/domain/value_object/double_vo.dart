import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class DoubleVO extends ValueObject<double> {
  DoubleVO(super.value) {
    _validate();
  }

  factory DoubleVO.text(String value) {
    try {
      return DoubleVO(double.parse(value));
    } on FormatException catch (_) {
      return DoubleVO(0);
    }
  }

  void _validate() {
    if (value <= 0) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText => toString();
}