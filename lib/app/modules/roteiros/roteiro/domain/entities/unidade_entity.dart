// ignore_for_file: public_member_api_docs, sort_constructors_first
class UnidadeEntity {
  final String id;
  final String codigo;
  final String descricao;
  final int decimal;

  const UnidadeEntity({
    required this.id,
    required this.codigo,
    required this.descricao,
    required this.decimal,
  });

  factory UnidadeEntity.empty() {
    return const UnidadeEntity(
      id: '',
      codigo: '',
      descricao: '',
      decimal: 0,
    );
  }

  factory UnidadeEntity.id(String id) {
    return UnidadeEntity(
      id: id,
      codigo: '',
      descricao: '',
      decimal: 0,
    );
  }

  UnidadeEntity copyWith({
    String? id,
    String? codigo,
    String? descricao,
    int? decimal,
  }) {
    return UnidadeEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      decimal: decimal ?? this.decimal,
    );
  }

  @override
  bool operator ==(covariant UnidadeEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.descricao == descricao && other.decimal == decimal;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ decimal.hashCode;
  }
}
