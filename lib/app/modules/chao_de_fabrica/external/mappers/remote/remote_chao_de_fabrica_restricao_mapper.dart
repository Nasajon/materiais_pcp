import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/enums/medicao_tempo_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_unidade_mapper.dart';

class RemoteChaoDeFabricaRestricaoMapper {
  const RemoteChaoDeFabricaRestricaoMapper._();

  static ChaoDeFabricaRestricaoEntity fromMapToRestricaoEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaRestricaoEntity(
      id: map['restricao']['restricao'],
      atividadeRestricaoId: map['atividade_restricao'],
      codigo: map['restricao']['codigo'],
      nome: map['restricao']['nome'],
      capacidade: DoubleVO(map['capacidade_total']),
      usar: DoubleVO(map['capacidade_utilizada']),
      inicioPlanejado: DateVO.parse(map['inicio_planejado']),
      fimPlanejado: DateVO.parse(map['fim_planejado']),
      medicaoTempo: MedicaoTempoRestricao.selectByValue(map['tipo_momento_execucao']),
      unidade: RemoteChaoDeFabricaUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
    );
  }
}
