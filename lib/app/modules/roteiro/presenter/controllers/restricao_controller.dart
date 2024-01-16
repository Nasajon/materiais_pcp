// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';

class RestricaoController {
  late final RxNotifier<RestricaoAggregate> _restricaoNotifier;

  RestricaoController({
    required RestricaoAggregate restricao,
  }) {
    _restricaoNotifier = RxNotifier(restricao);
  }

  RestricaoAggregate get restricao {
    return _restricaoNotifier.value;
  }

  set restricao(RestricaoAggregate value) {
    _restricaoNotifier.value = value;
    _restricaoNotifier.call();
  }

  RestricaoController copyWith() {
    return RestricaoController(
      restricao: _restricaoNotifier.value,
    );
  }
}
