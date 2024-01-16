import 'package:pcp_flutter/app/core/modules/domain/enums/roteiro_medicao_tempo_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/operacao_roteiro_entity.dart';

class RemoteOperacaoRoteiroMapper {
  const RemoteOperacaoRoteiroMapper._();

  static OperacaoRoteiroEntity fromMapToOperacaoRoteiro(Map<String, dynamic> map) {
    return OperacaoRoteiroEntity(
      operacaoId: map['operacao'],
      codigo: map['codigo'],
      nome: map['nome'],
      roteiroId: map['roteiro'],
      ordem: map['ordem'],
      razaoConversao: DoubleVO(map['razao_conversao']),
      medicaoTempo: RoteiroMedicaoTempoEnum.selectByValue(map['medicao_tempo']),
      preparacao: TimeVO(map['preparacao']),
      execucao: TimeVO(map['execucao']),
    );
  }
}
