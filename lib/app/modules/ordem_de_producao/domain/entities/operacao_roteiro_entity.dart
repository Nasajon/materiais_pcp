// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/enums/roteiro_medicao_tempo_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';

class OperacaoRoteiroEntity {
  final String operacaoId;
  final String codigo;
  final String nome;
  final String roteiroId;
  final int ordem;
  final DoubleVO razaoConversao;
  final RoteiroMedicaoTempoEnum medicaoTempo;
  final TimeVO preparacao;
  final TimeVO execucao;

  const OperacaoRoteiroEntity({
    required this.operacaoId,
    required this.codigo,
    required this.nome,
    required this.roteiroId,
    required this.ordem,
    required this.razaoConversao,
    required this.medicaoTempo,
    required this.preparacao,
    required this.execucao,
  });

  OperacaoRoteiroEntity copyWith({
    String? operacaoId,
    String? codigo,
    String? nome,
    String? roteiroId,
    int? ordem,
    DoubleVO? razaoConversao,
    RoteiroMedicaoTempoEnum? medicaoTempo,
    TimeVO? preparacao,
    TimeVO? execucao,
  }) {
    return OperacaoRoteiroEntity(
      operacaoId: operacaoId ?? this.operacaoId,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      roteiroId: roteiroId ?? this.roteiroId,
      ordem: ordem ?? this.ordem,
      razaoConversao: razaoConversao ?? this.razaoConversao,
      medicaoTempo: medicaoTempo ?? this.medicaoTempo,
      preparacao: preparacao ?? this.preparacao,
      execucao: execucao ?? this.execucao,
    );
  }

  @override
  bool operator ==(covariant OperacaoRoteiroEntity other) {
    if (identical(this, other)) return true;

    return other.operacaoId == operacaoId &&
        other.codigo == codigo &&
        other.nome == nome &&
        other.roteiroId == roteiroId &&
        other.ordem == ordem &&
        other.razaoConversao == razaoConversao &&
        other.medicaoTempo == medicaoTempo &&
        other.preparacao == preparacao &&
        other.execucao == execucao;
  }

  @override
  int get hashCode {
    return operacaoId.hashCode ^
        codigo.hashCode ^
        nome.hashCode ^
        roteiroId.hashCode ^
        ordem.hashCode ^
        razaoConversao.hashCode ^
        medicaoTempo.hashCode ^
        preparacao.hashCode ^
        execucao.hashCode;
  }
}
