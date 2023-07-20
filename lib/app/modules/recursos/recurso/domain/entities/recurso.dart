import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class Recurso {
  final String? id;
  final CodigoVO codigo;
  final TextVO descricao;
  final GrupoDeRecurso? grupoDeRecurso;
  final MoedaVO? custoHora;

  const Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.grupoDeRecurso,
    this.custoHora,
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
    TipoDeRecursoEnum? tipo,
    GrupoDeRecurso? grupoDeRecurso,
    MoedaVO? custoHora,
  }) {
    return Recurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRecurso: grupoDeRecurso ?? this.grupoDeRecurso,
      custoHora: custoHora ?? this.custoHora,
    );
  }
}
