import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum RoteiroMedicaoTempoEnum {
  porLote('por_lote'),
  tempoFixo('tempo_fixo'),
  porUnidade('por_unidade');

  final String value;

  const RoteiroMedicaoTempoEnum(this.value);

  String get name {
    switch (this) {
      case RoteiroMedicaoTempoEnum.porLote:
        return translation.types.tipoMedicaoTempoPorLote;
      case RoteiroMedicaoTempoEnum.tempoFixo:
        return translation.types.tipoMedicaoTempoTempoFixo;
      case RoteiroMedicaoTempoEnum.porUnidade:
        return translation.types.tipoMedicaoTempoPorUnidade;
    }
  }

  static RoteiroMedicaoTempoEnum selectByValue(String value) =>
      RoteiroMedicaoTempoEnum.values.where((medicao) => medicao.value == value).first;
}
