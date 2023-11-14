import 'package:pcp_flutter/app/core/localization/localizations.dart';

enum MedicaoTempoEnum {
  porLote('por_lote'),
  tempoFixo('tempo_fixo'),
  porUnidade('por_unidade');

  final String value;

  const MedicaoTempoEnum(this.value);

  String get name {
    switch (this) {
      case MedicaoTempoEnum.porLote:
        return translation.types.tipoMedicaoTempoPorLote;
      case MedicaoTempoEnum.tempoFixo:
        return translation.types.tipoMedicaoTempoTempoFixo;
      case MedicaoTempoEnum.porUnidade:
        return translation.types.tipoMedicaoTempoPorUnidade;
    }
  }

  static MedicaoTempoEnum selectByValue(String value) => MedicaoTempoEnum.values.where((medicao) => medicao.value == value).first;
}
