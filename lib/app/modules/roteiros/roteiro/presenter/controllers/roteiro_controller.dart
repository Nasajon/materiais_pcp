import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';

class RoteiroController {
  final GetRecursoPorGrupoUsecase _getRecursoPorGrupoUsecase;
  final GetRestricaoPorGrupoUsecase _getRestricaoPorGrupoUsecase;

  // List<OperacaoController> listOpercaoController = [];
  List<MaterialEntity> materiais = [];

  RoteiroController(
    this._getRecursoPorGrupoUsecase,
    this._getRestricaoPorGrupoUsecase,
  );

  // Controle da entidade do roteiro
  final _roteiroNotifier = RxNotifier(RoteiroAggregate.empty());
  RoteiroAggregate get roteiro {
    // final operacoes = listOpercaoController.map((controller) => controller.operacao).toList();
    return _roteiroNotifier.value;
  }

  set roteiro(RoteiroAggregate roteiro) {
    _roteiroNotifier.value = roteiro;
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

// Operações
  void setaOrdemOperacao({required int oldIndex, required int newIndex}) {
    final operacao = roteiro.operacoes[oldIndex];
    final operacoes = roteiro.operacoes;
    operacoes.removeAt(oldIndex);
    if (newIndex >= operacoes.length) {
      operacoes.add(operacao);
    } else {
      operacoes.insert(newIndex, operacao);
    }

    for (var i = 0; i < operacoes.length; i++) {
      operacoes[i] = operacoes[i].copyWith(ordem: i + 1);
    }

    roteiro = roteiro.copyWith(operacoes: operacoes);
  }

  // Materiais
  List<MaterialEntity> getMateriais([int? ordemOperacao]) {
    List<MaterialEntity> materiais = [];

    for (var operacao in roteiro.operacoes) {
      if (operacao.ordem != ordemOperacao) {
        for (var material in operacao.materiais) {
          if (material.produtoAdicional || material.fichaTecnicaId == null) continue;

          if (materiais.where((element) => element.produto.id == material.produto.id).isEmpty) {
            materiais.add(material.copyWith(disponivel: DoubleVO(0), quantidade: null));
          }

          final index = materiais.indexWhere((element) => element.produto.id == material.produto.id);

          var novoMaterial = materiais[index];

          novoMaterial = novoMaterial.copyWith(disponivel: DoubleVO(novoMaterial.disponivel.value + material.quantidade.value));

          materiais.setAll(index, [novoMaterial]);
        }
      }
    }

    if (ordemOperacao != null) {
      for (var operacao in roteiro.operacoes.where((operacao) => operacao.ordem == ordemOperacao)) {
        for (var material in operacao.materiais.where((material) => material.fichaTecnicaId == null || material.produtoAdicional)) {
          if (materiais.where((element) => element.produto.id == material.produto.id).isEmpty) {
            materiais.add(material);
          }
        }
      }
    }

    return materiais;
  }

  void removerOperacao(int ordemOperacao) {
    final operacoes = roteiro.operacoes;

    operacoes.removeWhere((operacao) => operacao.ordem == ordemOperacao);

    for (var i = 0; i < operacoes.length; i++) {
      operacoes[i] = operacoes[i].copyWith(ordem: i + 1);
    }

    roteiro = roteiro.copyWith(operacoes: operacoes);
  }
}
