import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/indisponibilidade_entity.dart';

class RestricaoFormController {
  final _restricao = RxNotifier(RestricaoAggregate.empty());
  RestricaoAggregate get restricao => _restricao.value;
  set restricao(RestricaoAggregate value) => _restricao.value = value;

  void restricaoNotifyListeners() => _restricao.call();

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
}
