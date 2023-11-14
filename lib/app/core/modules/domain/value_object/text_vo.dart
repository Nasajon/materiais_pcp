import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class TextVO extends ValueObject<String> {
  TextVO(super.value) {
    _validate();
  }

  void _validate() {
    if (value.isEmpty) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }
}
