import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class MoedaVO extends ValueObject<double?> {
  MoedaVO(super.value) {
    _validate();
  }

  factory MoedaVO.text(String value) {
    try {
      return MoedaVO(double.parse(value));
    } on FormatException catch (_) {
      return MoedaVO(0);
    }
  }

  void _validate() {
    if (value == null || value! <= 0) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText {
    if (value == null) {
      return '';
    }

    var textSplitted = value.toString().split('.');
    if (textSplitted[1] == '0') {
      return textSplitted[0];
    }
    return "${textSplitted[0]},${textSplitted[1]}";
  }
}
