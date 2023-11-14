import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/restricao_capacidade_dto.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteRestricaoCapacidadeMapper {
  const RemoteRestricaoCapacidadeMapper._();

  static RestricaoCapacidadeDTO fromMapToRestricaoCapacidadeDTO(Map<String, dynamic> map) {
    return RestricaoCapacidadeDTO(
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      capacidade: DoubleVO(map['capacidade']),
      usar: DoubleVO(map['quantidade_necessaria']),
      tempo: TimeVO(map['tempo_execucao']),
    );
  }

  static Map<String, dynamic> fromRestricaoCapacidadeToMap(RestricaoCapacidadeDTO restricaoCapacidade) {
    return {
      'unidade': restricaoCapacidade.unidade.id,
      'capacidade': restricaoCapacidade.capacidade.value,
      'quantidade_necessaria': restricaoCapacidade.usar.value,
      'tempo_execucao': restricaoCapacidade.tempo.timeFormat(shouldAddSeconds: true),
    };
  }
}
