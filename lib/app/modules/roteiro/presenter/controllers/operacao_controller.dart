import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/presenter/controllers/grupo_de_recurso_controller.dart';

class OperacaoController {
  String fichaTecnicaId = '';
  bool editar = false;
  final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;
  final RxNotifier<OperacaoAggregate> _operacaoNotifier = RxNotifier(OperacaoAggregate.empty());

  List<GrupoDeRecursoController> listGrupoRecursoController = [];

  List<MaterialEntity> materiais = [];

  OperacaoController(this._getRecursoPorGrupoUsecase, this._getRestricaoPorGrupoUsecase);

  OperacaoAggregate get operacao {
    final gruposDeRescursos = listGrupoRecursoController.map((controller) => controller.grupoDeRecurso).toList();
    return _operacaoNotifier.value.copyWith(gruposDeRecurso: gruposDeRescursos);
  }

  set operacao(OperacaoAggregate value) {
    _operacaoNotifier.value = value;

    listGrupoRecursoController = _operacaoNotifier.value.gruposDeRecurso
        .map((grupoDeRecurso) => GrupoDeRecursoController(
              grupoDeRecurso: grupoDeRecurso,
              getRecursoPorGrupoUsecase: _getRecursoPorGrupoUsecase,
              getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
            ))
        .toList();
  }

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
  }
}
