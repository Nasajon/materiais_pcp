import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/restricao_controller.dart';

class GrupoDeRestricaoController {
  late final RxNotifier<GrupoDeRestricaoAggregate> _grupoDeRestricaoNotifier;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  List<RestricaoController> listRestricaoController = [];

  GrupoDeRestricaoController({
    required GrupoDeRestricaoAggregate grupoDeRestricao,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _grupoDeRestricaoNotifier = RxNotifier(grupoDeRestricao);
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;

    _addListRestricaoController(_grupoDeRestricaoNotifier.value.restricoes);
  }

  Future<void> getRestricaoPorGrupo(String grupoDeRestricaoId) async {
    try {
      final restricaos = await _getRestricaoPorGrupoUsecase(grupoDeRestricaoId);
      _addListRestricaoController(restricaos);
    } on RoteiroFailure catch (error) {
      // TODO: Verificar uma forma de validar
    }
  }

  void _addListRestricaoController(List<RestricaoAggregate> restricaos) {
    listRestricaoController = restricaos
        .map(
          (restricao) => RestricaoController(
            restricao: restricao,
          ),
        )
        .toList();
  }

  GrupoDeRestricaoAggregate get grupoDeRestricao {
    final restricaos = listRestricaoController.map((controller) => controller.restricao).toList();
    return _grupoDeRestricaoNotifier.value.copyWith(restricoes: restricaos);
  }

  set grupoDeRestricao(GrupoDeRestricaoAggregate value) => _grupoDeRestricaoNotifier.value = value;

  // Restrições
  Future<void> adicionarRestricoes() async {
    try {
      final response = await _getRestricaoPorGrupoUsecase(grupoDeRestricao.grupo.id);

      if (response.isNotEmpty) {
        listRestricaoController = response
            .map(
              (recurso) => RestricaoController(
                restricao: recurso.copyWith(capacidade: grupoDeRestricao.capacidade),
              ),
            )
            .toList();
      }
    } on RoteiroFailure catch (error) {}
  }
}
