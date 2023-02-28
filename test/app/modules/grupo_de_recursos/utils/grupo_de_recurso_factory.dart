import 'package:pcp_flutter/app/core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoFactory {
  const GrupoDeRecursoFactory._();

  static GrupoDeRecurso create({
    String? id,
    String? codigo,
    String? descricao,
    TipoDeRecurso? tipoDeRecurso,
  }) {
    return GrupoDeRecurso(
      id: id,
      codigo: codigo ?? 'codigo',
      descricao: descricao ?? 'descricao',
      tipo: tipoDeRecurso ?? TipoDeRecurso.equipamento(),
    );
  }
}
