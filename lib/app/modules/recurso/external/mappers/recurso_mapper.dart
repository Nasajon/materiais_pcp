import 'package:flutter_core/ana_core.dart';

import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import '../../../grupo_de_recurso/external/mappers/grupo_de_recurso_mapper.dart';
import '../../domain/entities/recurso.dart';

class RecursoMapper {
  static Recurso fromMap(Map<String, dynamic> map) {
    try {
      return Recurso(
        id: map['recurso'] as String?,
        codigo: map['codigo'] as String,
        descricao: map['descricao'] as String,
        tipo: map['tipo'] != null ? TipoDeRecurso.fromMap(map['tipo']) : null,
        custoHora: map['custo_hora'] as double?,
        grupoDeRecurso: map['grupo_de_recurso'] != null
            ? GrupoDeRecursoMapper.fromMap(map['grupo_de_recurso'])
            : null,
      );
    } catch (error, stackTrace) {
      throw MapperError(
        errorMessage: 'Falha na serialização do recurso',
        exception: error,
        stackTrace: stackTrace,
        label: 'RecursoMapper.fromMap',
      );
    }
  }

  static Map<String, dynamic> toMap(Recurso recurso) {
    return {
      'recurso': recurso.id,
      'codigo': recurso.codigo,
      'descricao': recurso.descricao,
      'tipo': recurso.tipo?.value,
      'custo_hora': recurso.custoHora,
      'grupo_de_recurso': recurso.grupoDeRecurso?.id,
    };
  }
}
