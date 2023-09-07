// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/grupo_de_restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/grupo_de_restricao_controller.dart';

class RecursoController {
  final _recursoNotifier = RxNotifier(RecursoAggregate.empty());
  late final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  RecursoController({
    required RecursoAggregate recurso,
    required GetRestricaoPorGrupoUsecase getRestricaoPorGrupoUsecase,
  }) {
    _getRestricaoPorGrupoUsecase = getRestricaoPorGrupoUsecase;
    this.recurso = recurso;
  }

  RecursoAggregate get recurso {
    return _recursoNotifier.value;
  }

  set recurso(RecursoAggregate value) {
    _recursoNotifier.value = value;
  }

  // Grupo de Restrição
  GrupoDeRestricaoController get novoGrupoDeRestricaoController => GrupoDeRestricaoController(
        grupoDeRestricao: GrupoDeRestricaoAggregate.empty(),
        getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
      );

  Future<List<RestricaoAggregate>> _getRestricaoPorGrupo(String grupoDeRestricaoId) async {
    try {
      return await _getRestricaoPorGrupoUsecase(grupoDeRestricaoId);
    } on RoteiroFailure catch (error) {
      // TODO: Verificar uma forma de validar
    }

    return [];
  }

  Future<void> adicionarGrupoDeRestricao(GrupoDeRestricaoAggregate grupoDeRestricaoAggregate) async {
    final gruposDeRestricoes = recurso.grupoDeRestricoes;

    final restricoes = await _getRestricaoPorGrupo(grupoDeRestricaoAggregate.grupo.id);

    gruposDeRestricoes.add(
      grupoDeRestricaoAggregate.copyWith(
        restricoes: restricoes
            .map(
              (restricao) => restricao.copyWith(
                capacidade: grupoDeRestricaoAggregate.capacidade,
              ),
            )
            .toList(),
      ),
    );

    _recursoNotifier.value = recurso.copyWith(grupoDeRestricoes: gruposDeRestricoes);
  }

  List<GrupoDeRestricaoController> get listGrupoDeRestricaoController => recurso.grupoDeRestricoes
      .map((grupoDeRestricao) => GrupoDeRestricaoController(
            grupoDeRestricao: grupoDeRestricao,
            getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
          ))
      .toList();

  RecursoController copyWith() {
    return RecursoController(
      recurso: recurso,
      getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
    );
  }
}
