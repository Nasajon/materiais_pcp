import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';

class RoteiroController {
  final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  List<OperacaoController> listOpercaoController = [];
  List<MaterialEntity> materiais = [];

  RoteiroController(
    this._getRecursoPorGrupoUsecase,
    this._getRestricaoPorGrupoUsecase,
  );

  // Controle da entidade do roteiro
  final _roteiroNotifier = RxNotifier(RoteiroAggregate.empty());
  RoteiroAggregate get roteiro {
    final operacoes = listOpercaoController.map((controller) => controller.operacao).toList();
    return _roteiroNotifier.value.copyWith(operacoes: operacoes);
  }

  set roteiro(RoteiroAggregate roteiro) {
    _roteiroNotifier.value = roteiro;

    listOpercaoController = roteiro.operacoes
        .map((operacao) => OperacaoController(
              fichaTecnicaId: roteiro.fichaTecnica.id,
              operacao: operacao,
              getRecursoPorGrupoUsecase: _getRecursoPorGrupoUsecase,
              getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
            ))
        .toList();
  }

  // Operação
  OperacaoController get newOperacaoController {
    return OperacaoController(
      fichaTecnicaId: roteiro.fichaTecnica.id,
      operacao: OperacaoAggregate.empty(),
      getRecursoPorGrupoUsecase: _getRecursoPorGrupoUsecase,
      getRestricaoPorGrupoUsecase: _getRestricaoPorGrupoUsecase,
    );
  }

  // Controle do PageView, Steps, TabsButton
  final _pageIndexNotifier = RxNotifier(0);
  int get pageIndex => _pageIndexNotifier.value;
  set pageIndex(int value) => _pageIndexNotifier.value = value;

  bool get isValidStep {
    switch (pageIndex) {
      case 0:
        return roteiro.dadosBasicosIsValid;
      case 1:
        return roteiro.periodoDeVigenciaIsValid;
      case 2:
        return roteiro.operacoesIsValid;
    }

    return roteiro.isValid;
  }
}
