// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';

class ChaoDeFabricaAtividadeFilter {
  final String search;
  final List<ChaoDeFabricaCentroDeTrabalhoEntity> centrosDeTrabalhos;
  final List<ChaoDeFabricaRecursoEntity> recursos;
  final List<AtividadeStatusEnum> atividadeStatus;
  final DateVO dataInicial;
  final DateVO dataFinal;
  final String ultimaAtividadeId;

  ChaoDeFabricaAtividadeFilter({
    ChaoDeFabricaCentroDeTrabalhoEntity? centroDeTrabalho,
    ChaoDeFabricaRecursoEntity? recurso,
    this.search = '',
    this.centrosDeTrabalhos = const [],
    this.recursos = const [],
    this.atividadeStatus = const [],
    DateVO? dataInicial,
    DateVO? dataFinal,
    this.ultimaAtividadeId = '',
  })  : this.dataInicial = dataInicial ?? DateVO.empty(),
        this.dataFinal = dataFinal ?? DateVO.empty();

  ChaoDeFabricaAtividadeFilter copyWith({
    String? search,
    List<ChaoDeFabricaCentroDeTrabalhoEntity>? centrosDeTrabalhos,
    List<ChaoDeFabricaRecursoEntity>? recursos,
    List<AtividadeStatusEnum>? atividadeStatus,
    DateVO? dataInicial,
    DateVO? dataFinal,
    String? ultimaAtividadeId,
  }) {
    return ChaoDeFabricaAtividadeFilter(
      search: search ?? this.search,
      centrosDeTrabalhos: centrosDeTrabalhos ?? this.centrosDeTrabalhos,
      recursos: recursos ?? this.recursos,
      atividadeStatus: atividadeStatus ?? this.atividadeStatus,
      dataInicial: dataInicial ?? this.dataInicial,
      dataFinal: dataFinal ?? this.dataFinal,
      ultimaAtividadeId: ultimaAtividadeId ?? this.ultimaAtividadeId,
    );
  }

  @override
  bool operator ==(covariant ChaoDeFabricaAtividadeFilter other) {
    if (identical(this, other)) return true;

    return other.search == search &&
        listEquals(other.centrosDeTrabalhos, centrosDeTrabalhos) &&
        listEquals(other.recursos, recursos) &&
        listEquals(other.atividadeStatus, atividadeStatus) &&
        other.dataInicial == dataInicial &&
        other.dataFinal == dataFinal &&
        other.ultimaAtividadeId == ultimaAtividadeId;
  }

  @override
  int get hashCode {
    return search.hashCode ^
        centrosDeTrabalhos.hashCode ^
        recursos.hashCode ^
        atividadeStatus.hashCode ^
        dataInicial.hashCode ^
        dataFinal.hashCode ^
        ultimaAtividadeId.hashCode;
  }
}
