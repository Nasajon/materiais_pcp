// ignore_for_file: public_member_api_docs, sort_constructors_first
class SequenciamentoObjectEntity {
  final String id;
  final String codigo;
  final String nome;

  const SequenciamentoObjectEntity({
    required this.id,
    required this.codigo,
    required this.nome,
  });

  SequenciamentoObjectEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
  }) {
    return SequenciamentoObjectEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant SequenciamentoObjectEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
