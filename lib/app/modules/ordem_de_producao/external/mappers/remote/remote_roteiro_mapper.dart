import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_unidade_mapper.dart';

class RemoteRoteiroMapper {
  const RemoteRoteiroMapper._();

  static RoteiroEntity fromMapToRoteiroEntity(Map<String, dynamic> map) {
    return RoteiroEntity(
      id: map['roteiro'],
      codigo: map['codigo'],
      nome: map['descricao'],
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
    );
  }
}
