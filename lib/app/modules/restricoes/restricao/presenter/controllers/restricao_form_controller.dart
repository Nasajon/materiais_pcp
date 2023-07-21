import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/disponibilidade_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/indisponibilidade_entity.dart';

class RestricaoFormController {
  final _restricao = RxNotifier(RestricaoAggregate.empty());
  RestricaoAggregate get restricao => _restricao.value;
  set restricao(RestricaoAggregate value) => _restricao.value = value;

  final _indisponibilidade = RxNotifier<IndisponibilidadeEntity?>(null);
  IndisponibilidadeEntity? get indisponibilidade => _indisponibilidade.value;
  set indisponibilidade(IndisponibilidadeEntity? value) => _indisponibilidade.value = value;

  void criarEditarIndisponibilidade(IndisponibilidadeEntity indisponibilidade) {
    if (indisponibilidade.codigo == 0) {
      restricao.indisponibilidades.add(
        indisponibilidade,
      );
    } else {
      restricao.indisponibilidades[indisponibilidade.codigo - 1] = indisponibilidade;
    }

    for (var i = 0; i < restricao.indisponibilidades.length; i++) {
      restricao.indisponibilidades[i] = restricao.indisponibilidades[i].copyWith(codigo: i + 1);
    }

    this.indisponibilidade = null;
    restricao = restricao.copyWith();
  }

  void removerIndisponibilidade(int index) {
    restricao.indisponibilidades.removeAt(index - 1);

    for (var i = 0; i < restricao.indisponibilidades.length; i++) {
      restricao.indisponibilidades[i] = restricao.indisponibilidades[i].copyWith(codigo: i + 1);
    }

    restricao = restricao.copyWith();
  }

  final _disponibilidade = RxNotifier<DisponibilidadeEntity?>(null);
  DisponibilidadeEntity? get disponibilidade => _disponibilidade.value;
  set disponibilidade(DisponibilidadeEntity? value) => _disponibilidade.value = value;

  void criarEditarDisponibilidade(DisponibilidadeEntity disponibilidade) {
    if (disponibilidade.codigo == 0) {
      restricao.disponibilidades.add(
        disponibilidade,
      );
    } else {
      restricao.disponibilidades[disponibilidade.codigo - 1] = disponibilidade;
    }

    for (var i = 0; i < restricao.disponibilidades.length; i++) {
      restricao.disponibilidades[i] = restricao.disponibilidades[i].copyWith(codigo: i + 1);
    }

    this.disponibilidade = null;
    restricao = restricao.copyWith();
  }

  void removerDisponibilidade(int index) {
    restricao.disponibilidades.removeAt(index - 1);

    for (var i = 0; i < restricao.disponibilidades.length; i++) {
      restricao.disponibilidades[i] = restricao.disponibilidades[i].copyWith(codigo: i + 1);
    }

    restricao = restricao.copyWith();
  }
}
