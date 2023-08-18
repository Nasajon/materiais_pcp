import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';

class RemoteRecursoCapacidadeMapper {
  const RemoteRecursoCapacidadeMapper._();

  static RecursoCapacidadeDTO fromMapToRecursoCapacidadeDTO(Map<String, dynamic> map) {
    return RecursoCapacidadeDTO(
      preparacao: TimeVO('tempo_de_preparacao'),
      execucao: TimeVO(map['tempo_de_processamento']),
      capacidadeTotal: DoubleVO(map['quantidade_total']),
      minima: DoubleVO(map['quantidade_minima']),
      maxima: DoubleVO(map['quantidade_maxima']),
    );
  }

  static Map<String, dynamic> fromRecursoCapacidadeToMap(RecursoCapacidadeDTO recursoCapacidade) {
    return {
      'tempo_de_preparacao': recursoCapacidade.preparacao.timeFormat(shouldAddSeconds: true),
      'tempo_de_processamento': recursoCapacidade.execucao.timeFormat(shouldAddSeconds: true),
      'quantidade_total': recursoCapacidade.capacidadeTotal.value,
      'quantidade_minima': recursoCapacidade.minima.value,
      'quantidade_maxima': recursoCapacidade.maxima.value,
    };
  }
}
