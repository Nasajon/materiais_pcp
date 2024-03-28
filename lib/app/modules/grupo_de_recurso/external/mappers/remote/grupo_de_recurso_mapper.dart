import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoMapper {
  static GrupoDeRecurso fromMap(Map<String, dynamic> map) {
    try {
      return GrupoDeRecurso(
        id: map['grupo_de_recurso'],
        codigo: CodigoVO(map['codigo']),
        descricao: TextVO(map['nome']),
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

  static Map<String, dynamic> toMap(GrupoDeRecurso grupoDeRecurso) {
    return {
      'grupoderecurso': grupoDeRecurso.id,
      'codigo': grupoDeRecurso.codigo.toText,
      'nome': grupoDeRecurso.descricao.value,
      'tipo': grupoDeRecurso.tipo?.value,
    };
  }
}
