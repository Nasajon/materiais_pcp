import 'package:flutter_core/ana_core.dart';

import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import '../../domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoMapper {
  static GrupoDeRecurso fromMap(Map<String, dynamic> map) {
    try {
      return GrupoDeRecurso(
        id: map['grupo_de_recurso'] as String?,
        codigo: map['codigo'] as String,
        descricao: map['descricao'] as String,
        tipo: map['tipo'] != null ? TipoDeRecurso.fromMap(map['tipo']) : null,
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

  static Map<String, dynamic> toMap(GrupoDeRecurso grupoDeRecurso) {
    return {
      'grupoderecurso': grupoDeRecurso.id,
      'codigo': grupoDeRecurso.codigo,
      'descricao': grupoDeRecurso.descricao,
      'tipo': grupoDeRecurso.tipo?.value,
    };
  }
}
