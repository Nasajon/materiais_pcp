import 'package:pcp_flutter/app/core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';

class RecursoFactory {
  const RecursoFactory._();

  static Recurso create(
      {String? id,
      String? codigo,
      String? descricao,
      TipoDeRecurso? tipoDeRecurso,
      GrupoDeRecurso? grupoDeRecurso,
      double? custoHora}) {
    return Recurso(
      id: id,
      codigo: codigo ?? 'codigo',
      descricao: descricao ?? 'descricao',
      tipo: tipoDeRecurso ?? TipoDeRecurso.equipamento(),
      grupoDeRecurso: grupoDeRecurso,
      custoHora: custoHora,
    );
  }
}
