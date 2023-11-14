import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/remote/grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/mapper/remote/remote_indisponibilidade_mapper.dart';

class RemoteRestricaoMapper {
  const RemoteRestricaoMapper._();

  static RestricaoAggregate fromMapToRestricaoAggregate(Map<String, dynamic> map) {
    return RestricaoAggregate(
      id: map['restricao'],
      codigo: CodigoVO.text(map['codigo']),
      descricao: TextVO(map['nome']),
      grupoDeRestricao: GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(map['grupo_de_restricao']),
      indisponibilidades: map['indisponibilidades'] != null
          ? List.from(map['indisponibilidades']).map((e) => RemoteIndisponibilidadeMapper.fromMapToIndisponibilidadeEntity(e)).toList()
          : [],
    );
  }

  static Map<String, dynamic> fromRestricaoAggregateToMap(RestricaoAggregate restricao) {
    return {
      'codigo': restricao.codigo.toText,
      'nome': restricao.descricao.value,
      'grupo_de_restricao': restricao.grupoDeRestricao?.id,
      'indisponibilidades': restricao.indisponibilidades
          .map((indisponibilidade) => RemoteIndisponibilidadeMapper.fromIndisponibilidadeEntityToMap(indisponibilidade))
          .toList(),
    };
  }
}
