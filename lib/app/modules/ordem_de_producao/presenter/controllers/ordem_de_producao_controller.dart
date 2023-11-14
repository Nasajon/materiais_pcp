import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';

class OrdemDeProducaoController {
  final ordemDeProducaoNotifier = RxNotifier(OrdemDeProducaoAggregate.empty());
  OrdemDeProducaoAggregate get ordemDeProducao => ordemDeProducaoNotifier.value;
  set ordemDeProducao(OrdemDeProducaoAggregate value) => ordemDeProducaoNotifier.value = value;
}
