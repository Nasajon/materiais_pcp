import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/external/mappers/remote/grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/external/mappers/remote/recurso_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/external/mappers/remote/remote_turno_de_trabalho_mapper.dart';

import '../../../domain/entities/recurso.dart';

class RecursoMapper {
  static Recurso fromMap(Map<String, dynamic> map) {
    try {
      return Recurso(
        id: map['recurso'] as String?,
        codigo: CodigoVO.text(map['codigo']),
        descricao: TextVO(map['nome']),
        grupoDeRecurso: GrupoDeRecursoMapper.fromMapToGrupoDeRecurso(map['grupo_de_recurso']),
        centroDeTrabalho: map['centro_de_trabalho'] != null
            ? RecursoCentroDeTrabalhoMapper.fromMapToRecursoCentroDeTrabalho(map['centro_de_trabalho'])
            : RecursoCentroDeTrabalho.empty(),
        turnos: List.from(map['turnos']).map((map) => RemoteTurnoDeTrabalhoMapper.fromMapToRecursoTurnoTrabalho(map)).toList(),
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
      'tipo': recurso.grupoDeRecurso.tipo?.value,
      'grupo_de_recurso': recurso.grupoDeRecurso.id,
      'centro_de_trabalho': recurso.centroDeTrabalho.id,
      'turnos': recurso.turnos.map((turno) => RemoteTurnoDeTrabalhoMapper.fromTurnoTrabalhoToMap(turno)).toList(),
    };
  }
}
