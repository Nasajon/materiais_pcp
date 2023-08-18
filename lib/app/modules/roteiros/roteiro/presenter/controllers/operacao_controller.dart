import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';

class InserirEditarOperacaoController {
  late final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;
  late final OperacaoAggregate _operacao;

  List<GrupoDeRecursoController> listGrupoRecursoController = [];

  InserirEditarOperacaoController({
    required OperacaoAggregate operacao,
    required GetRecursoPorGrupoUsecase getRecursoPorGrupoUsecase,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _operacao = operacao;
    _getRecursoPorGrupoUsecase = getRecursoPorGrupoUsecase;
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;

    listGrupoRecursoController = _operacao.gruposDeRecurso
        .map((grupoDeRecurso) => GrupoDeRecursoController(
              grupoDeRecurso: grupoDeRecurso,
              getRecursoPorGrupoUsecase: getRecursoPorGrupoUsecase,
              getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
            ))
        .toList();
  }

  OperacaoAggregate get operacao {
    final gruposDeRescursos = listGrupoRecursoController.map((controller) => controller.grupoDeRecurso).toList();
    return _operacao.copyWith(gruposDeRecurso: gruposDeRescursos);
  }
}
