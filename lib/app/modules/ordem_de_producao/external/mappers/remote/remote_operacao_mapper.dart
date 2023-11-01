import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_material_mapper.dart';

class RemoteOperacaoMapper {
  const RemoteOperacaoMapper._();

  static OperacaoAggregate fromMapToOperacaoEntity(Map<String, dynamic> map) {
    return OperacaoAggregate(
      ordem: map['ordem'],
      nome: map['nome'],
      centroDeTrabalho: RemoteCentroDeTrabalhoMapper.fromMapToCentroDeTrabalho(map['centro_de_trabalho']),
      materiais: List.from(map['produtos']).map((map) => RemoteMaterialMapper.fromMapToMaterial(map)).toList(),
      grupoDeRecursos:
          List.from(map['grupos_recursos']).map((map) => RemoteGrupoDeRecursoMapper.fromMapToGrupoDeRecursoEntity(map)).toList(),
    );
  }
}
