import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/enums/medicao_tempo_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_restricao_capacidade_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_restricao_mapper.dart';

class RemoteGrupoDeRestricaoMapper {
  const RemoteGrupoDeRestricaoMapper._();

  static GrupoDeRestricaoEntity fromMapToGrupoDeRestricao(Map<String, dynamic> map) {
    return GrupoDeRestricaoEntity(
      id: map['grupo_de_restricao'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }

  static GrupoDeRestricaoAggregate fromMapToGrupoDeRestricaoAggregate(Map<String, dynamic> map) {
    return GrupoDeRestricaoAggregate(
      grupo: fromMapToGrupoDeRestricao(map['grupo_de_restricao']),
      quando: MedicaoTempoRestricao.selectByValue(map['momento_necessidade']),
      capacidade: RemoteRestricaoCapacidadeMapper.fromMapToRestricaoCapacidadeDTO(map),
      restricoes: List.from(map['restricoes']).map((map) => RemoteRestricaoMapper.fromMapToRestricaoAggregate(map)).toList(),
    );
  }

  static Map<String, dynamic> fromGrupoDeRestricaoAggregateToMap(GrupoDeRestricaoAggregate grupoDeRestricao) {
    return {
      'grupo_de_restricao': grupoDeRestricao.grupo.id,
      'momento_necessidade': grupoDeRestricao.quando?.value,
      ...RemoteRestricaoCapacidadeMapper.fromRestricaoCapacidadeToMap(grupoDeRestricao.capacidade),
      'restricoes': grupoDeRestricao.restricoes.map((restricao) => RemoteRestricaoMapper.fromRestricaoAggregateToMap(restricao)).toList(),
    };
  }
}
