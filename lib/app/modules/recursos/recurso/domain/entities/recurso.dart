import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class Recurso {
  final String? id;
  final String codigo;
  final String descricao;
  final GrupoDeRecurso? grupoDeRecurso;
  final double? custoHora;

  const Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.grupoDeRecurso,
    this.custoHora,
  });

  factory Recurso.empty() {
    return const Recurso(
      codigo: '',
      descricao: '',
    );
  }

  Recurso copyWith({
    String? id,
    String? codigo,
    String? descricao,
    TipoDeRecursoEnum? tipo,
    GrupoDeRecurso? grupoDeRecurso,
    double? custoHora,
  }) {
    return Recurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRecurso: grupoDeRecurso ?? this.grupoDeRecurso,
      custoHora: custoHora ?? this.custoHora,
    );
  }
}
