import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_material_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_operacao_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_ordem_de_producao_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_restricao_mapper.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_unidade_mapper.dart';

class RemoteChaoDeFabricaAtividadeMapper {
  const RemoteChaoDeFabricaAtividadeMapper._();

  static ChaoDeFabricaAtividadeAggregate fromMapToAtividadeAggregate(Map<String, dynamic> map) {
    return ChaoDeFabricaAtividadeAggregate(
      id: map['atividade_recurso'],
      status: AtividadeStatusEnum.selectByValue(map['status']),
      inicioPlanejado: DateVO.parse(map['inicio_planejado']),
      fimPlanejado: DateVO.parse(map['fim_planejado']),
      inicioPreparacaoPlanejado: DateVO.parse(map['inicio_preparacao_planejada']),
      fimPreparacaoPlanejado: DateVO.parse(map['fim_preparacao_planejada']),
      progresso: map['progresso'],
      capacidade: DoubleVO(map['capacidade']),
      unidade: RemoteChaoDeFabricaUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      ordemDeProducao: RemoteChaoDeFabricaOrdemDeProducaoMapper.fromMapToOrdemDeProducaoEntity(map['operacao_ordem']['ordem_de_producao']),
      operacao: RemoteChaoDeFabricaOperacaoMapper.fromMapToOperacaoEntity(map['operacao_ordem']),
      recurso: RemoteChaoDeFabricaRecursoMapper.fromMapToRecurso(map['recurso']),
      restricoes: List.from(map['restricoes']).map((restricaoMap) {
        return RemoteChaoDeFabricaRestricaoMapper.fromMapToRestricaoEntity(restricaoMap);
      }).toList(),
      materiais: List.from(map['produtos']).map((produtoMap) {
        return RemoteChaoDeFabricaMaterialMapper.fromMapToMaterialEntity(produtoMap);
      }).toList(),
    );
  }
}
