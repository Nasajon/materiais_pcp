// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/origem_ordem_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/prioridade_enum.dart';

class OrdemDeProducaoEntity {
  final String id;
  final String codigo;
  final DateVO previsaoDeEntrega;
  final DoubleVO quantidade;
  final OrigemOrdemEnum origem;
  final String status;
  final PrioridadeEnum prioridade;

  const OrdemDeProducaoEntity({
    required this.id,
    required this.codigo,
    required this.previsaoDeEntrega,
    required this.quantidade,
    required this.origem,
    required this.status,
    required this.prioridade,
  });

  OrdemDeProducaoEntity copyWith({
    String? id,
    String? codigo,
    DateVO? previsaoDeEntrega,
    DoubleVO? quantidade,
    OrigemOrdemEnum? origem,
    String? status,
    PrioridadeEnum? prioridade,
  }) {
    return OrdemDeProducaoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      previsaoDeEntrega: previsaoDeEntrega ?? this.previsaoDeEntrega,
      quantidade: quantidade ?? this.quantidade,
      origem: origem ?? this.origem,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
    );
  }

  @override
  bool operator ==(covariant OrdemDeProducaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.previsaoDeEntrega == previsaoDeEntrega &&
        other.quantidade == quantidade &&
        other.origem == origem &&
        other.status == status &&
        other.prioridade == prioridade;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        previsaoDeEntrega.hashCode ^
        quantidade.hashCode ^
        origem.hashCode ^
        status.hashCode ^
        prioridade.hashCode;
  }
}
