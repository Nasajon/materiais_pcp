import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';

class RoteiroEntity {
  final String id;
  final String codigo;
  final String descricao;
  final ProdutoEntity produto;

  const RoteiroEntity({
    required this.id,
    required this.codigo,
    required this.descricao,
    required this.produto,
  });

  RoteiroEntity copyWith({
    String? id,
    String? codigo,
    String? descricao,
    ProdutoEntity? produto,
  }) {
    return RoteiroEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      produto: produto ?? this.produto,
    );
  }
}
