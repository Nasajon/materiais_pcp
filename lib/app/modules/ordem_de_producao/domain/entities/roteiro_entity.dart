import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/unidade_entity.dart';

class RoteiroEntity {
  final String id;
  final String codigo;
  final String nome;
  final UnidadeEntity unidade;

  const RoteiroEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.unidade,
  });

  factory RoteiroEntity.empty() {
    return RoteiroEntity(id: '', codigo: '', nome: '', unidade: UnidadeEntity.empty());
  }

  RoteiroEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    UnidadeEntity? unidade,
  }) {
    return RoteiroEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      unidade: unidade ?? this.unidade,
    );
  }

  @override
  bool operator ==(covariant RoteiroEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.unidade == unidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ unidade.hashCode;
  }
}
