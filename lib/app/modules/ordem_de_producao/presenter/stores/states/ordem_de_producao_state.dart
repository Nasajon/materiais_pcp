// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/aprovar_ordem_de_producao_store.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/presenter/stores/deletar_ordem_de_producao_store.dart';

class OrdemDeProducaoState {
  final OrdemDeProducaoAggregate ordemDeProducao;
  final DeletarOrdemDeProducaoStore deletarOrdemDeProducaoStore;
  final AprovarOrdemDeProducaoStore aprovarOrdemDeProducaoStore;

  const OrdemDeProducaoState({
    required this.ordemDeProducao,
    required this.deletarOrdemDeProducaoStore,
    required this.aprovarOrdemDeProducaoStore,
  });
}
