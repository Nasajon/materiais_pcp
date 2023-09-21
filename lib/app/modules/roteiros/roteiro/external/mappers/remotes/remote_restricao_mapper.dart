import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/restricao_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_restricao_capacidade_mapper.dart';

class RemoteRestricaoMapper {
  const RemoteRestricaoMapper._();

  static RestricaoAggregate fromMapToRestricao(Map<String, dynamic> map) {
    return RestricaoAggregate(
      id: map['restricao'],
      codigo: map['codigo'],
      nome: map['nome'],
      capacidade: RestricaoCapacidadeDTO.empty(),
    );
  }

  static RestricaoAggregate fromMapToRestricaoAggregate(Map<String, dynamic> map) {
    return RestricaoAggregate(
      id: map['restricao']['restricao'],
      codigo: map['restricao']['codigo'],
      nome: map['restricao']['nome'],
      capacidade: RemoteRestricaoCapacidadeMapper.fromMapToRestricaoCapacidadeDTO(map),
    );
  }

  static Map<String, dynamic> fromRestricaoAggregateToMap(RestricaoAggregate restricao) {
    return {
      'restricao': restricao.id,
      ...RemoteRestricaoCapacidadeMapper.fromRestricaoCapacidadeToMap(restricao.capacidade),
    };
  }
}
