import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';
import 'package:pcp_flutter/app/core/constants/app_localization.dart';

class TextVO extends ValueObject<String> {
  TextVO(super.value) {
    _validate();
  }

  void _validate() {
    if (value.isEmpty) {
      errorMessage = AppLocalization.l10n.messages.errorCampoObrigatorio;
    }
  }
}
