import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class Recurso {
  final String? id;
  final String codigo;
  final String descricao;
  final TipoDeRecursoEnum? tipo;
  final GrupoDeRecurso? grupoDeRecurso;
  final double? custoHora;

  const Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    required this.tipo,
    this.grupoDeRecurso,
    this.custoHora,
  });
}
