enum MedicaoTempoEnum {
  porLote('por_lote'),
  tempoFixo('tempo_fixo'),
  porUnidade('por_unidade');

  final String value;

  const MedicaoTempoEnum(this.value);

  String get name {
    return '';
  }

  static MedicaoTempoEnum selectByValue(String value) => MedicaoTempoEnum.values.where((medicao) => medicao.value == value).first;
}
