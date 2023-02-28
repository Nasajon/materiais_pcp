class TipoDeRecurso {
  final String name;
  final String value;

  TipoDeRecurso({required this.name, required this.value});

  factory TipoDeRecurso.maoDeObra() =>
      TipoDeRecurso(name: 'Mão de obra', value: 'mao_de_obra');

  factory TipoDeRecurso.postoDeTrabalho() =>
      TipoDeRecurso(name: 'Posto de trabalho', value: 'posto_de_trabalho');

  factory TipoDeRecurso.equipamento() =>
      TipoDeRecurso(name: 'Equipamento', value: 'equipamento');

  factory TipoDeRecurso.outros() =>
      TipoDeRecurso(name: 'Outros', value: 'outros');

  factory TipoDeRecurso.fromMap(String tipoDeRecurso) {
    switch (tipoDeRecurso) {
      case 'mao_de_obra':
        return TipoDeRecurso.maoDeObra();
      case 'posto_de_trabalho':
        return TipoDeRecurso.postoDeTrabalho();
      case 'equipamento':
        return TipoDeRecurso.equipamento();
      default:
        return TipoDeRecurso.outros();
    }
  }

  @override
  bool operator ==(covariant TipoDeRecurso other) {
    if (identical(this, other)) return true;

    return other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
