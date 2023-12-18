import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';

class SequenciamentoController {
  // Controle do PageView, Steps, TabsButton
  final _pageIndexNotifier = RxNotifier(0);
  int get pageIndex => _pageIndexNotifier.value;
  set pageIndex(int value) => _pageIndexNotifier.value = value;

  final _sequenciamentoAggregateNotifier = RxNotifier(SequenciamentoAggregate.empty());
  SequenciamentoAggregate get sequenciamento => _sequenciamentoAggregateNotifier.value;
  set sequenciamento(SequenciamentoAggregate value) => _sequenciamentoAggregateNotifier.value = value;

  // Lista de ordem de produção
  final _listOrdemProducaoNotifier = RxNotifier(<OrdemDeProducaoAggregate>[]);
  List<OrdemDeProducaoAggregate> get listOrdemDeProducao => _listOrdemProducaoNotifier.value;

  List<String> get ordensIds => listOrdemDeProducao.map((ordemDeProducao) => ordemDeProducao.id).toList();

  void addOrdemDeProducao(List<OrdemDeProducaoAggregate> listOrdemDeProducao) {
    _listOrdemProducaoNotifier.value.addAll(listOrdemDeProducao);
    _listOrdemProducaoNotifier();
  }

  void atualizarOrdemDeProducao(OrdemDeProducaoAggregate ordemDeProducao) {
    for (var i = 0; i < listOrdemDeProducao.length; i++) {
      if (listOrdemDeProducao[i].id == ordemDeProducao.id) {
        _listOrdemProducaoNotifier.value.setAll(i, [ordemDeProducao]);
        _listOrdemProducaoNotifier();
        break;
      }
    }
  }

  void deletarOrdemdeProducao(OrdemDeProducaoAggregate ordemDeProducao) {
    _listOrdemProducaoNotifier.value.removeWhere((element) => element.id == ordemDeProducao.id);
    _listOrdemProducaoNotifier();
  }

  // Lista das operacoes
  final _listOperacoesNotifier = RxNotifier(<OperacaoAggregate>[]);
  List<OperacaoAggregate> get listOperacoes => _listOperacoesNotifier.value;

  void addOperacao(List<OperacaoAggregate> operacoes) {
    for (var operacao in operacoes) {
      bool temOperacao = listOperacoes.where((op) => op.id == operacao.id).isNotEmpty;

      if (!temOperacao) {
        _listOperacoesNotifier.value.add(operacao);
        // _listOperacoesNotifier();
      }
    }

    for (var operacao in listOperacoes) {
      operacao.grupoDeRecursos.forEach(
        (grupoDeRecurso) => grupoDeRecurso.recursos.forEach(
          (recurso) {
            if (!recursosIds.contains(recurso.id)) {
              addRecursoId(recurso.id);
            }
          },
        ),
      );
    }

    for (var operacao in listOperacoes) {
      operacao.grupoDeRecursos.forEach(
        (grupoDeRecurso) => grupoDeRecurso.recursos.forEach(
          (recurso) => recurso.grupoDeRestricoes.forEach(
            (grupoDeRestricao) => grupoDeRestricao.restricoes.forEach(
              (restricao) {
                if (!restricaoIds.contains(restricao.id)) {
                  addRestricaoId(restricao.id);
                }
              },
            ),
          ),
        ),
      );
    }
  }

  // Recursos
  final recursosIdsNotifier = ValueNotifier(<String>[]);
  List<String> get recursosIds => recursosIdsNotifier.value;
  void addRecursoId(String value) {
    recursosIdsNotifier.value.add(value);
    recursosIdsNotifier.value = List.from(recursosIdsNotifier.value);
  }

  void removeRecursoId(String value) {
    recursosIdsNotifier.value.remove(value);
    recursosIdsNotifier.value = List.from(recursosIdsNotifier.value);
  }

  // Restrições
  final restricaoIdsNotifier = ValueNotifier(<String>[]);
  List<String> get restricaoIds => restricaoIdsNotifier.value;
  void addRestricaoId(String value) {
    restricaoIdsNotifier.value.add(value);
    restricaoIdsNotifier.value = List.from(restricaoIdsNotifier.value);
  }

  void removeRestricaoId(String value) {
    restricaoIdsNotifier.value.remove(value);
    restricaoIdsNotifier.value = List.from(restricaoIdsNotifier.value);
  }

  SequenciamentoDTO get sequenciamentoDTO => SequenciamentoDTO(
        ordensIds: ordensIds,
        recursosIds: recursosIds,
        restricoesIds: restricaoIds,
      );
}
