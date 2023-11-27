import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_evento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_operacao_roteiro_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_ordem_de_producao_mapper.dart';

class RemoteSequencimantoRecursoEventoMapper {
  const RemoteSequencimantoRecursoEventoMapper._();

  static SequenciamentoRecursoEventoAggregate fromMapToSequenciamentoRecursoEvento(Map<String, dynamic> map) {
    return SequenciamentoRecursoEventoAggregate(
      id: map['evento_recurso'],
      ordemDeProducao: RemoteOrdemDeProducaoMapper.fromMapToOrdemDeProducaoEntity(map['ordem_de_producao']),
      operacaoRoteiro: RemoteOperacaoRoteiroMapper.fromMapToOperacaoRoteiro(map['operacao_roteiro']),
      inicioPlanejado: DateVO.date(DateTime.parse(map['inicio_planejado'])),
      fimPlanejado: DateVO.date(DateTime.parse(map['fim_planejado'])),
    );
  }
}
