class RestricaoCentroDeTrabalho {
  final String id;
  final String codigo;
  final String nome;

  const RestricaoCentroDeTrabalho({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  factory RestricaoCentroDeTrabalho.empty() {
    return const RestricaoCentroDeTrabalho(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  RestricaoCentroDeTrabalho copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return RestricaoCentroDeTrabalho(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant RestricaoCentroDeTrabalho other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
