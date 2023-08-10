import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';

class RemoteRecursoMapper {
  const RemoteRecursoMapper._();

  static RecursoAggregate fromMapToRecursoAggregate(Map<String, dynamic> map) {
    return RecursoAggregate(
      id: map['recurso'],
      codigo: map['codigo'],
      nome: map['nome'],
      capacidade: RecursoCapacidadeDTO.empty(),
    );
  }
}
