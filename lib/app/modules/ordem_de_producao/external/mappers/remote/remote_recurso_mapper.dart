import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/recurso_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_grupo_de_restricao_mapper.dart';

class RemoteRecursoMapper {
  const RemoteRecursoMapper._();

  static RecursoEntity fromMapToRecurso(Map<String, dynamic> map) {
    return RecursoEntity(
      id: map['recurso']['recurso'],
      codigo: map['recurso']['codigo'],
      nome: map['recurso']['nome'],
      grupoDeRestricoes:
          List.from(map['grupos_restricoes']).map((map) => RemoteGrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(map)).toList(),
    );
  }

  static RecursoEntity fromMapToSequenciamentoRecurso(Map<String, dynamic> map) {
    return RecursoEntity(
      id: map['recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
      grupoDeRestricoes: [],
    );
  }
}
