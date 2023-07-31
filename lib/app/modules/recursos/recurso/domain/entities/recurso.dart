// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';

class Recurso {
  final String? id;
  final CodigoVO codigo;
  final TextVO descricao;
  final GrupoDeRecurso? grupoDeRecurso;
  final RecursoCentroDeTrabalho? centroDeTrabalho;

  const Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.grupoDeRecurso,
    this.centroDeTrabalho,
  });

  factory Recurso.empty() {
    return Recurso(
      codigo: CodigoVO(null),
      descricao: TextVO(''),
    );
  }

  Recurso copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? descricao,
    GrupoDeRecurso? grupoDeRecurso,
    RecursoCentroDeTrabalho? centroDeTrabalho,
  }) {
    return Recurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRecurso: grupoDeRecurso ?? this.grupoDeRecurso,
      centroDeTrabalho: centroDeTrabalho ?? this.centroDeTrabalho,
    );
  }

  @override
  bool operator ==(covariant Recurso other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.grupoDeRecurso == grupoDeRecurso &&
        other.centroDeTrabalho == centroDeTrabalho;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ grupoDeRecurso.hashCode ^ centroDeTrabalho.hashCode;
  }
}
