import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/enum/tipo_unidade_enum.dart';

class RestricaoAggregate {
  final String? id;
  final String? codigo;
  final String descricao;
  final GrupoDeRestricaoEntity grupoDeRestricao;
  final TipoUnidadeEnum tipoUnidade;
  final int capacidadeProducao;
  final double custoPorHora;
  final bool limitarCapacidadeProducao;
  final List<IndisponibilidadeEntity> indisponibilidades;

  const RestricaoAggregate({
    this.id,
    this.codigo,
    required this.descricao,
    required this.grupoDeRestricao,
    required this.tipoUnidade,
    required this.capacidadeProducao,
    required this.custoPorHora,
    required this.limitarCapacidadeProducao,
    required this.indisponibilidades,
  });
}
