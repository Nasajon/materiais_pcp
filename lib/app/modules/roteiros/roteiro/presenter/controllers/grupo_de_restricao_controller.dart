import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/restricao_controller.dart';

class GrupoDeRestricaoController {
  final _grupoDeRestricaoNotifier = RxNotifier(GrupoDeRestricaoAggregate.empty());
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  GrupoDeRestricaoController({
    required GrupoDeRestricaoAggregate grupoDeRestricao,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;
    this.grupoDeRestricao = grupoDeRestricao;
  }

  List<RestricaoController> get listRestricaoController => grupoDeRestricao.restricoes
      .map(
        (restricao) => RestricaoController(
          restricao: restricao,
        ),
      )
      .toList();

  GrupoDeRestricaoAggregate get grupoDeRestricao {
    return _grupoDeRestricaoNotifier.value;
  }

  set grupoDeRestricao(GrupoDeRestricaoAggregate value) {
    _grupoDeRestricaoNotifier.value = value;
    _grupoDeRestricaoNotifier.call();
  }

  // Restrições
  // Future<void> adicionarRestricoes() async {
  //   try {
  //     final response = await _getRestricaoPorGrupoUsecase(grupoDeRestricao.grupo.id);

  //     grupoDeRestricao = grupoDeRestricao.copyWith(restricoes: response);
  //   } on RoteiroFailure catch (error) {}
  // }

  void editarRestricao(RestricaoAggregate restricao) {
    int index = grupoDeRestricao.restricoes.indexWhere((r) => r.id == restricao.id);

    grupoDeRestricao.restricoes.setAll(index, [restricao]);
    grupoDeRestricao = grupoDeRestricao.copyWith(restricoes: grupoDeRestricao.restricoes);
  }
}
