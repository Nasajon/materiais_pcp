import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_sequenciamento_recurso_mapper.dart';

class RemoteSequenciamentoMapper {
  const RemoteSequenciamentoMapper._();

  static SequenciamentoAggregate fromMapToSequenciamento(Map<String, dynamic> map) {
    return SequenciamentoAggregate(
      tempoInicial: DateVO.date(DateTime.parse(map['tempo_inicial'])),
      tempoFinal: DateVO.date(DateTime.parse(map['tempo_final'])),
      sequenciamentoRecursos: List.from(map['sequenciamento_recursos'])
          .map(
            (map) => RemoteSequenciamentoObjectMapper.fromMapToSequenciamentoObject(map),
          )
          .toList(),
      sequenciamentoRestricoes: List.from(map['sequenciamento_restricoes'])
          .map(
            (map) => RemoteSequenciamentoObjectMapper.fromMapToSequenciamentoObject(map),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> fromSequenciamentoTopMap(SequenciamentoAggregate sequenciamento) {
    final map = {
      "tempo_inicial": sequenciamento.tempoInicial.dateFormat(format: "yyyy-MM-ddTHH:mm:ss"),
      "tempo_final": sequenciamento.tempoFinal.dateFormat(format: "yyyy-MM-ddTHH:mm:ss"),
      "sequenciamento_recursos": sequenciamento.sequenciamentoRecursos
          .map((recurso) => RemoteSequenciamentoObjectMapper.fromSequenciamentoObjectToMap(
                recurso,
                isRecurso: true,
              ))
          .toList(),
      "sequenciamento_restricoes": sequenciamento.sequenciamentoRestricoes
          .map((restricao) => RemoteSequenciamentoObjectMapper.fromSequenciamentoObjectToMap(
                restricao,
                isRecurso: false,
              ))
          .toList(),
    };

    return map;
  }
}
