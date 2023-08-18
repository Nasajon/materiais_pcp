// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/recurso_controller.dart';

class GrupoDeRecursoController {
  late final GrupoDeRecursoAggregate _grupoDeRecurso;
  late final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  List<RecursoController> listRecursoController = [];

  GrupoDeRecursoController({
    required GrupoDeRecursoAggregate grupoDeRecurso,
    required GetRecursoPorGrupoUsecase getRecursoPorGrupoUsecase,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _grupoDeRecurso = grupoDeRecurso;
    _getRecursoPorGrupoUsecase = getRecursoPorGrupoUsecase;
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;

    _addListRecursoController(_grupoDeRecurso.recursos);
  }

  Future<void> getRecursoPorGrupo(String grupoDeRecursoId) async {
    try {
      final recursos = await _getRecursoPorGrupoUsecase(grupoDeRecursoId);
      _addListRecursoController(recursos);
    } on RoteiroFailure catch (error) {
      // TODO: Verificar uma forma de validar
    }
  }

  void _addListRecursoController(List<RecursoAggregate> recursos) {
    listRecursoController = recursos
        .map(
          (recurso) => RecursoController(
            recurso: recurso,
            getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
          ),
        )
        .toList();
  }

  GrupoDeRecursoAggregate get grupoDeRecurso {
    final recursos = listRecursoController.map((controller) => controller.recurso).toList();
    return _grupoDeRecurso.copyWith(recursos: recursos);
  }
}
