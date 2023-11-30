import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_restricao_mapper.dart';

class RemoteGrupoDeRestricaoMapper {
  const RemoteGrupoDeRestricaoMapper._();

  static GrupoDeRestricaoEntity fromMapToGrupoDeRestricaoEntity(Map<String, dynamic> map) {
    return GrupoDeRestricaoEntity(
      id: map['grupo_de_restricao']['grupo_de_restricao'],
      codigo: map['grupo_de_restricao']['codigo'],
      nome: map['grupo_de_restricao']['nome'],
      restricoes: List.from(map['restricoes']).map((map) => RemoteRestricaoMapper.fromMapToRestricao(map['restricao'])).toList(),
    );
  }
}
