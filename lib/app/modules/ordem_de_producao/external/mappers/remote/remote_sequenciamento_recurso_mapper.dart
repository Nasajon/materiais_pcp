import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_sequenciamento_recurso_evento_mapper.dart';

class RemoteSequenciamentoRecursoMapper {
  const RemoteSequenciamentoRecursoMapper._();

  static SequenciamentoRecursoAggregate fromMapToSequenciamentoRecurso(Map<String, dynamic> map) {
    return SequenciamentoRecursoAggregate(
      recurso: RemoteRecursoMapper.fromMapToRecurso(map['recurso']),
      eventos: List.from(map['events'])
          .map(
            (map) => RemoteSequencimantoRecursoEventoMapper.fromMapToSequenciamentoRecursoEvento(map),
          )
          .toList(),
    );
  }
}
