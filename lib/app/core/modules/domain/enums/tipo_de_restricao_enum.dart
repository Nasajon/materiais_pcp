enum TipoDeRestricaoEnum {
  componentes(value: 'componentes', description: 'Componentes'),
  equipamento(value: 'equipamento', description: 'Equipamento'),
  ferramenta(value: 'ferramenta', description: 'Ferramenta'),
  maoDeObra(value: 'mao_de_obra', description: 'Mão de obra'),
  outros(value: 'outros', description: 'Outros');

  final String value;
  final String description;

  const TipoDeRestricaoEnum({required this.value, required this.description});

  static TipoDeRestricaoEnum selectTipoRestricao(String value) {
    return TipoDeRestricaoEnum.values.where((tipo) => value == tipo.value).first;
  }
}
