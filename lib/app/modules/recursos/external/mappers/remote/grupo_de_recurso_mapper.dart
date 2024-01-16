import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_grupo_de_recurso.dart';

class GrupoDeRecursoMapper {
  const GrupoDeRecursoMapper._();

  static RecursoGrupoDeRecurso fromMapToGrupoDeRecurso(Map<String, dynamic> map) {
    try {
      return RecursoGrupoDeRecurso(
        id: map['grupo_de_recurso'],
        codigo: map['codigo'],
        nome: map['nome'],
        tipo: map['tipo'] != null ? TipoDeRecursoEnum.selecTipoDeRecurso(map['tipo']) : null,
      );
    } catch (error, stackTrace) {
      throw MapperError(
        errorMessage: 'Falha na serialização do grupo de recurso',
        exception: error,
        stackTrace: stackTrace,
        label: 'GrupoDeRecursoMapper.fromMap',
      );
    }
  }
}
