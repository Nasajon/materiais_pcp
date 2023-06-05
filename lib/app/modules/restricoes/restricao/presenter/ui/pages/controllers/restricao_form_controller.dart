import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';

class RestricaoFormController {
  final _restricao = RxNotifier(RestricaoAggregate.empty());
  RestricaoAggregate get restricao => _restricao.value;
  set restricao(RestricaoAggregate value) => _restricao.value = value;
}
