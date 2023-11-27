import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
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

  final ordensIdsNotifier = ValueNotifier(<String>[]);
  List<String> get ordensIds => ordensIdsNotifier.value;
  void addOrdemId(String value) {
    ordensIdsNotifier.value.add(value);
    ordensIdsNotifier.value = List.from(ordensIdsNotifier.value);
  }

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

  SequenciamentoDTO get sequenciamentoDTO => SequenciamentoDTO(ordensIds: ordensIds, recursosIds: recursosIds);
}
