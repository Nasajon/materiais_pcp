// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/integer_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/tipo_unidade_enum.dart';

class RestricaoAggregate {
  final String? id;
  final CodigoVO? codigo;
  final TextVO descricao;
  final GrupoDeRestricaoEntity? grupoDeRestricao;
  final TipoUnidadeEnum? tipoUnidade;
  final IntegerVO capacidadeProducao;
  final MoedaVO custoPorHora;
  final bool limitarCapacidadeProducao;
  final List<IndisponibilidadeEntity> indisponibilidades;

  const RestricaoAggregate({
    this.id,
    this.codigo,
    required this.descricao,
    this.grupoDeRestricao,
    this.tipoUnidade,
    required this.capacidadeProducao,
    required this.custoPorHora,
    required this.limitarCapacidadeProducao,
    required this.indisponibilidades,
  });

  factory RestricaoAggregate.empty() {
    return RestricaoAggregate(
      descricao: TextVO(''),
      capacidadeProducao: IntegerVO(0),
      custoPorHora: MoedaVO(0),
      limitarCapacidadeProducao: false,
      indisponibilidades: [],
    );
  }

  RestricaoAggregate copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? descricao,
    GrupoDeRestricaoEntity? grupoDeRestricao,
    TipoUnidadeEnum? tipoUnidade,
    IntegerVO? capacidadeProducao,
    MoedaVO? custoPorHora,
    bool? limitarCapacidadeProducao,
    List<IndisponibilidadeEntity>? indisponibilidades,
  }) {
    return RestricaoAggregate(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      grupoDeRestricao: grupoDeRestricao ?? this.grupoDeRestricao,
      tipoUnidade: tipoUnidade ?? this.tipoUnidade,
      capacidadeProducao: capacidadeProducao ?? this.capacidadeProducao,
      custoPorHora: custoPorHora ?? this.custoPorHora,
      limitarCapacidadeProducao: limitarCapacidadeProducao ?? this.limitarCapacidadeProducao,
      indisponibilidades: indisponibilidades ?? this.indisponibilidades,
    );
  }

  bool get dadosGeraisIsValid => (codigo != null && codigo!.isValid) && descricao.isValid && grupoDeRestricao != null;

  bool get capacidadeIsValid => tipoUnidade != null && capacidadeProducao.isValid && custoPorHora.isValid;

  bool get indisponibilidadeIsValid => true;

  bool get isValid => dadosGeraisIsValid && capacidadeIsValid && indisponibilidadeIsValid;
}
