import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

class RemoteUnidadeMapper {
  const RemoteUnidadeMapper._();

  static UnidadeEntity fromMapToUnidadeEntity(Map<String, dynamic> map) {
    return UnidadeEntity(
      id: map['id'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      decimal: map['decimal'] ?? 0,
    );
  }
}
