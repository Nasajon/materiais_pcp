enum TipoDeRecursoEnum {
  maoDeObra(value: 'mao_de_obra', name: 'Mão de obra'),
  postoDeTrabalho(value: 'posto_de_trabalho', name: 'Posto de trabalho'),
  equipamento(value: 'equipamento', name: 'Equipamento'),
  outros(value: 'outros', name: 'Outros');

  final String value;
  final String name;

  const TipoDeRecursoEnum({required this.value, required this.name});

  static TipoDeRecursoEnum selecTipoDeRecurso(String value) {
    return TipoDeRecursoEnum.values.where((tipo) => tipo.value == value).first;
  }
}
