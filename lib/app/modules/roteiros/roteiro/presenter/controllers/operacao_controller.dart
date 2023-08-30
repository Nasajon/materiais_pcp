import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';

class OperacaoController {
  final String fichaTecnicaId;
  late final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;
  late final RxNotifier<OperacaoAggregate> _operacaoNotifier;

  List<GrupoDeRecursoController> listGrupoRecursoController = [];

  OperacaoController({
    required this.fichaTecnicaId,
    required OperacaoAggregate operacao,
    required GetRecursoPorGrupoUsecase getRecursoPorGrupoUsecase,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _operacaoNotifier = RxNotifier(operacao);
    _getRecursoPorGrupoUsecase = getRecursoPorGrupoUsecase;
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;

    listGrupoRecursoController = _operacaoNotifier.value.gruposDeRecurso
        .map((grupoDeRecurso) => GrupoDeRecursoController(
              grupoDeRecurso: grupoDeRecurso,
              getRecursoPorGrupoUsecase: getRecursoPorGrupoUsecase,
              getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
            ))
        .toList();
  }

  OperacaoAggregate get operacao {
    final gruposDeRescursos = listGrupoRecursoController.map((controller) => controller.grupoDeRecurso).toList();
    return _operacaoNotifier.value.copyWith(gruposDeRecurso: gruposDeRescursos);
  }

  set operacao(OperacaoAggregate value) => _operacaoNotifier.value = value;

  // Grupo de Recursos
  GrupoDeRecursoController get novoGrupoDeRecursoController => GrupoDeRecursoController(
        grupoDeRecurso: GrupoDeRecursoAggregate.empty(),
        getRecursoPorGrupoUsecase: _getRecursoPorGrupoUsecase,
        getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
      );

  set adicionarGrupoDeRecursoController(GrupoDeRecursoController controller) {
    listGrupoRecursoController.add(controller);
    _operacaoNotifier.call();
  }

  void removerGrupoDeRecurso(String grupoRecursoId) {
    listGrupoRecursoController.removeWhere((controller) => controller.grupoDeRecurso.grupo.id == grupoRecursoId);
    _operacaoNotifier.call();
  }
}
