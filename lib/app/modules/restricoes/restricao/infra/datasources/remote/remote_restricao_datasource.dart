import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';

abstract class RemoteRestricaoDatasource {
  Future<List<RestricaoAggregate>> getList([String? search]);
  Future<RestricaoAggregate> insert(RestricaoAggregate restricao);
  Future<bool> update(RestricaoAggregate restricao);
}
