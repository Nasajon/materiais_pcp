enum StatusOrdemDeProducaoEnum {
  aberta('aberta'),
  aprovada('aprovada'),
  planejada('planejada'),
  emProducao('em_producao'),
  produzida('produzida'),
  cancelada('cancelada');

  final String code;

  const StatusOrdemDeProducaoEnum(this.code);

  static StatusOrdemDeProducaoEnum select(String code) {
    return StatusOrdemDeProducaoEnum.values.where((value) => value.code == code).first;
  }
}
