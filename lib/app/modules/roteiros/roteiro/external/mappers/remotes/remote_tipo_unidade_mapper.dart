import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';

class RemoteTipoUnidadeMapper {
  const RemoteTipoUnidadeMapper._();

  static TipoUnidadeEntity fromMapToTipoUnidadeEntity(Map<String, dynamic> map) {
    return TipoUnidadeEntity(
      id: map['id'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      decimal: map['decimal'] ?? 0,
    );
  }
}
