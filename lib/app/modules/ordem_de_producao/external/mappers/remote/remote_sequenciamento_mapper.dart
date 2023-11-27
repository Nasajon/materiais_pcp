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
            (map) => RemoteSequenciamentoRecursoMapper.fromMapToSequenciamentoRecurso(map),
          )
          .toList(),
    );
  }
}
