import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';

class RecursoController {
  late final RecursoAggregate _recurso;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;
  List<GrupoDeRestricaoController> listGrupoDeRestricaoController = [];

  RecursoController({
    required RecursoAggregate recurso,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _recurso = recurso;
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
    return _recurso.copyWith(grupoDeRestricoes: gruposDeRestricoes);
  }
}
