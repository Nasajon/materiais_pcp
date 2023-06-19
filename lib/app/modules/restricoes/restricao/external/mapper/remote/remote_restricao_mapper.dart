import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/integer_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/external/mapper/remote/grupo_de_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/tipo_unidade_enum.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/mapper/remote/remote_disponibilidade_mapper.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/external/mapper/remote/remote_indisponibilidade_mapper.dart';

class RemoteRestricaoMapper {
  const RemoteRestricaoMapper._();

  static RestricaoAggregate fromMapToRestricaoAggregate(Map<String, dynamic> map) {
    return RestricaoAggregate(
      id: map['restricao'],
      codigo: CodigoVO.text(map['codigo']),
      descricao: TextVO(map['descricao']),
      grupoDeRestricao: GrupoDeRestricaoMapper.fromMapToGrupoDeRestricaoEntity(map['grupo']),
      tipoUnidade: TipoUnidadeEnum.selectTipoUnidade(map['tipo_unidade']),
      capacidadeProducao: IntegerVO(map['capacidade_producao']),
      custoPorHora: MoedaVO(map['custo_por_hora']),
      limitarCapacidadeProducao: map['limitar_capacidade_producao'],
      indisponibilidades: (map['indisponibilidades'] as List<Map<String, dynamic>>)
          .map((e) => RemoteIndisponibilidadeMapper.fromMapToIndisponibilidadeEntity(e))
          .toList(),
      disponibilidades: (map['disponibilidades'] as List<Map<String, dynamic>>)
          .map((e) => RemoteDisponibilidadeMapper.fromMapToDisponibilidadeEntity(e))
          .toList(),
    );
  }
}
