import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';

abstract class RestricaoRepository {
  Future<List<RestricaoAggregate>> getRestricaoRecente();
  Future<List<RestricaoAggregate>> getList([String? search]);
  Future<RestricaoAggregate> getRestricaoPorId(String id);
  Future<RestricaoAggregate> insert(RestricaoAggregate restricao);
  Future<bool> update(RestricaoAggregate restricao);
  Future<bool> delete(String id);
}
