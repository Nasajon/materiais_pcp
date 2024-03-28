import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_indisponibilidade_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_restricao_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/remote_turno_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/restricao/external/mapper/remote/restricao_grupo_de_restricao_mapper.dart';

class RemoteRestricaoMapper {
  const RemoteRestricaoMapper._();

  static RestricaoAggregate fromMapToRestricaoAggregate(Map<String, dynamic> map) {
    return RestricaoAggregate(
      id: map['restricao'],
      codigo: CodigoVO(map['codigo']),
      descricao: TextVO(map['nome']),
      grupoDeRestricao: RestricaoGrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(map['grupo_de_restricao']),
      centroDeTrabalho: RemoteRestricaoCentroDeTrabalhoMapper.fromMapToRestricaoCentroDeTrabalho(map['centro_de_trabalho']),
      indisponibilidades: map['indisponibilidades'] != null
          ? List.from(map['indisponibilidades']).map((e) => RemoteIndisponibilidadeMapper.fromMapToIndisponibilidadeEntity(e)).toList()
          : [],
      turnos: List.from(map['turnos']).map((map) => RemoteTurnoDeTrabalhoMapper.fromMapToRestricaoTurnoTrabalho(map)).toList(),
    );
  }

  static Map<String, dynamic> fromRestricaoAggregateToMap(RestricaoAggregate restricao) {
    return {
      'codigo': restricao.codigo.toText,
      'nome': restricao.descricao.value,
      'grupo_de_restricao': restricao.grupoDeRestricao.id,
      'centro_de_trabalho': restricao.centroDeTrabalho.id,
      'indisponibilidades': restricao.indisponibilidades
          .map((indisponibilidade) => RemoteIndisponibilidadeMapper.fromIndisponibilidadeEntityToMap(indisponibilidade))
          .toList(),
      'turnos': restricao.turnos.map((turno) => RemoteTurnoDeTrabalhoMapper.fromTurnoTrabalhoToMap(turno)).toList(),
    };
  }
}
