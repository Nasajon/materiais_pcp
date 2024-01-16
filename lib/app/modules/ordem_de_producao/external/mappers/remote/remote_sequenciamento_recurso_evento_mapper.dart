import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_operacao_roteiro_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_ordem_de_producao_mapper.dart';

class RemoteSequencimantoEventoMapper {
  const RemoteSequencimantoEventoMapper._();

  static SequenciamentoEventoAggregate fromMapToSequenciamentoEvento(Map<String, dynamic> map) {
    return SequenciamentoEventoAggregate(
      eventoRecursoId: map['evento_recurso'],
      eventoRestricaoId: map.containsKey('evento_restricao') ? map['evento_restricao'] : null,
      recursoId: map.containsKey('recurso') && !map.containsKey('restricao') ? map['recurso'] : map['recurso']['recurso'],
      restricaoId: map.containsKey('restricao') ? map['restricao'] : null,
      capacidade: (map['capacidade'] is int) ? DoubleVO((map['capacidade'] as int).toDouble()) : DoubleVO(map['capacidade']),
      ordemDeProducao: RemoteOrdemDeProducaoMapper.fromMapToOrdemDeProducaoEntity(map['ordem_de_producao']),
      operacaoRoteiro: RemoteOperacaoRoteiroMapper.fromMapToOperacaoRoteiro(map['operacao_roteiro']),
      inicioPlanejado: DateVO.date(DateTime.parse(map['inicio_planejado'])),
      fimPlanejado: DateVO.date(DateTime.parse(map['fim_planejado'])),
      inicioPreparacaoPlanejada: map['inicio_preparacao_planejada'] != null && (map['inicio_preparacao_planejada'] as String).isNotEmpty
          ? DateVO.date(DateTime.parse(map['inicio_preparacao_planejada']))
          : null,
      fimPreparacaoPlanejada: map['fim_preparacao_planejada'] != null && (map['fim_preparacao_planejada'] as String).isNotEmpty
          ? DateVO.date(DateTime.parse(map['fim_preparacao_planejada']))
          : null,
    );
  }

  static Map fromSequenciamentoEventoToMap(SequenciamentoEventoAggregate evento) {
    final map = <String, dynamic>{
      'evento_recurso': evento.eventoRecursoId,
      'recurso': evento.recursoId,
      'restricao': evento.restricaoId,
      'capacidade': evento.capacidade.value,
      'ordem_de_producao': evento.ordemDeProducao.id,
      'operacao_roteiro': evento.operacaoRoteiro.operacaoId,
      'inicio_planejado': evento.inicioPlanejado.dateFormat(format: "yyyy-MM-ddThh:mm:ss"),
      'fim_planejado': evento.fimPlanejado.dateFormat(format: "yyyy-MM-ddThh:mm:ss"),
    };

    if (evento.eventoRestricaoId != null) {
      map['evento_restricao'] = evento.eventoRestricaoId;
    }

    return map;
  }
}
