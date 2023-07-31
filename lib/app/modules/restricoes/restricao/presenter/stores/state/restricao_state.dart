// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/deletar_restricao_store.dart';

class RestricaoState {
  final RestricaoAggregate restricao;
  final DeletarRestricaoStore deletarStore;

  RestricaoState({
    required this.restricao,
    required this.deletarStore,
  });

  RestricaoState copyWith({
    RestricaoAggregate? restricao,
    DeletarRestricaoStore? deletarStore,
  }) {
    return RestricaoState(
      restricao: restricao ?? this.restricao,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
