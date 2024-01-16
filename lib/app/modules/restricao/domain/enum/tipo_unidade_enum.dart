enum TipoUnidadeEnum {
  decimetroCubico(value: 'decimetro_cubico', description: 'Decímetro cúbico (dm3)');

  final String value;
  final String description;

  const TipoUnidadeEnum({required this.value, required this.description});

  static selectTipoUnidade(String value) {
    return TipoUnidadeEnum.values.where((tipo) => tipo.value == value).first;
  }
}
