import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class GrupoDeRecursoMapper {
  const GrupoDeRecursoMapper._();

  static GrupoDeRecurso fromMapToGrupoDeRecurso(Map<String, dynamic> map) {
    try {
      return GrupoDeRecurso(
        id: map['grupo_de_recurso'] as String?,
        codigo: map['codigo'] as String,
        descricao: map['descricao'] as String,
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
