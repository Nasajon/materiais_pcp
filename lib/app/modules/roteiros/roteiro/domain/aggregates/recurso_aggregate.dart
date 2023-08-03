import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/dtos/recurso_capacidade_dto.dart';

class RecursoAggregate {
  final String id;
  final String codigo;
  final String nome;
  final RecursoCapacidadeDTO capacidade;

  const RecursoAggregate({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.capacidade,
  });

  RecursoAggregate copyWith({
    String? id,
    String? codigo,
    String? nome,
    RecursoCapacidadeDTO? capacidade,
  }) {
    return RecursoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      capacidade: capacidade ?? this.capacidade,
    );
  }

  @override
  bool operator ==(covariant RecursoAggregate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.capacidade == capacidade;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ capacidade.hashCode;
  }
}
