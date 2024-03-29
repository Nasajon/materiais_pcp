import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/value_object.dart';

class DoubleVO extends ValueObject<double?> {
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
    if (super.value == null) {
      errorMessage = translation.messages.errorCampoObrigatorio;
    }
  }

  String get toText => toString();
  bool get cannotBeZeroed => super.value != null && super.value! <= 0;

  @override
  double get value => super.value ?? 0;
  double? get valueOrNull => super.value;

  String formatDoubleToString({int decimalDigits = 2}) {
    var valueText = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: decimalDigits,
    ).format(value).trim();

    if (decimalDigits == 0) {
      valueText = valueText.replaceAll('.', '');
    }

    return valueText;
  }
}
