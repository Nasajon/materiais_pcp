import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/remote/grupo_de_recurso_mapper.dart';

import '../../../domain/entities/recurso.dart';

class RecursoMapper {
  static Recurso fromMap(Map<String, dynamic> map) {
    try {
      return Recurso(
        id: map['recurso'] as String?,
        codigo: CodigoVO.text(map['codigo']),
        descricao: TextVO(map['nome']),
        custoHora: map['custo_hora'] != null ? MoedaVO(map['custo_hora']) : null,
        grupoDeRecurso: map['grupo_de_recurso'] != null ? GrupoDeRecursoMapper.fromMap(map['grupo_de_recurso']) : null,
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
      'codigo': recurso.codigo.toText,
      'nome': recurso.descricao.value,
      'tipo': recurso.grupoDeRecurso?.tipo?.value,
      'custo_hora': recurso.custoHora?.value,
      'grupo_de_recurso': recurso.grupoDeRecurso?.id,
    };
  }
}
