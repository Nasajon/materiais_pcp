import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';

class RecursoController {
  late final RxNotifier<RecursoAggregate> _recursoNotifier;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;
  List<GrupoDeRestricaoController> listGrupoDeRestricaoController = [];

  RecursoController({
    required RecursoAggregate recurso,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _recursoNotifier = RxNotifier(recurso);
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;

    listGrupoDeRestricaoController = recurso.grupoDeRestricoes
        .map((grupoDeRestricao) => GrupoDeRestricaoController(
              grupoDeRestricao: grupoDeRestricao,
              getRestricaoPorGrupoUsecase: getRestricaoPorGrupoUsecase,
            ))
        .toList();
  }

  RecursoAggregate get recurso {
    final gruposDeRestricoes = listGrupoDeRestricaoController.map((controller) => controller.grupoDeRestricao).toList();
    return _recursoNotifier.value.copyWith(grupoDeRestricoes: gruposDeRestricoes);
  }

  set recurso(RecursoAggregate value) {
    _recursoNotifier.value = value;
    _recursoNotifier.call();
  }

  // Grupo de Restrição
  GrupoDeRestricaoController get novoGrupoDeRestricaoController => GrupoDeRestricaoController(
        grupoDeRestricao: GrupoDeRestricaoAggregate.empty(),
        getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
      );

  set adicionarGrupoDeRestricaoController(GrupoDeRestricaoController controller) {
    listGrupoDeRestricaoController.add(controller);
    _recursoNotifier.call();
  }
}
