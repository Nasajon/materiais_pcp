// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/unidade_entity.dart';

class ProdutoEntity {
  final String id;
  final String codigo;
  final String nome;
  final UnidadeEntity? unidade;

  const ProdutoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    this.unidade,
  });

  factory ProdutoEntity.empty() {
    return const ProdutoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  factory ProdutoEntity.id(String id) {
    return ProdutoEntity(
      id: id,
      codigo: '',
      nome: '',
    );
  }

  ProdutoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    UnidadeEntity? unidade,
  }) {
    return ProdutoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      unidade: unidade ?? this.unidade,
    );
  }

  @override
  bool operator ==(covariant ProdutoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ codigo.hashCode ^ nome.hashCode;
}
