import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_object_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_sequenciamento_object_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_sequenciamento_recurso_evento_mapper.dart';

class RemoteSequenciamentoObjectMapper {
  const RemoteSequenciamentoObjectMapper._();

  static SequenciamentoObjectAggregate fromMapToSequenciamentoObject(Map<String, dynamic> map) {
    return SequenciamentoObjectAggregate(
      eventObject: RemoteSequenciamentoRecursoERestricaoMapper.fromMapToSequenciamentoSequenciamentoObject(
        map.containsKey('recurso') ? map['recurso'] : map['restricao'],
      ),
      eventos: List.from(map['events'])
          .map(
            (map) => RemoteSequencimantoEventoMapper.fromMapToSequenciamentoEvento(map),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> fromSequenciamentoObjectToMap(SequenciamentoObjectAggregate object, {bool isRecurso = true}) {
    final map = <String, dynamic>{
      'events': object.eventos
          .map((evento) => RemoteSequencimantoEventoMapper.fromSequenciamentoEventoToMap(
                evento,
              ))
          .toList(),
    };

    if (isRecurso) {
      map['recurso'] = object.eventObject.id;
    } else {
      map['restricao'] = object.eventObject.id;
    }

    return map;
  }
}
