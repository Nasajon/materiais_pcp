import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';

class MaterialEntity {
  final String material;
  final TipoUnidadeEntity tipoUnidade;
  final double disponivel;
  final double quantidade;

  const MaterialEntity({
    required this.material,
    required this.tipoUnidade,
    required this.disponivel,
    required this.quantidade,
  });

  @override
  bool operator ==(covariant MaterialEntity other) {
    if (identical(this, other)) return true;

    return other.material == material &&
        other.tipoUnidade == tipoUnidade &&
        other.disponivel == disponivel &&
        other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return material.hashCode ^ tipoUnidade.hashCode ^ disponivel.hashCode ^ quantidade.hashCode;
  }
}
