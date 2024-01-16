import 'package:pcp_flutter/app/modules/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/repositories/restricao_repository.dart';

abstract class GetRestricaoRecenteUsecase {
  Future<List<RestricaoAggregate>> call();
}

class GetRestricaoRecenteUsecaseImpl implements GetRestricaoRecenteUsecase {
  final RestricaoRepository _restricaoRepository;

  const GetRestricaoRecenteUsecaseImpl(this._restricaoRepository);

  @override
  Future<List<RestricaoAggregate>> call() {
    return _restricaoRepository.getRestricaoRecente();
  }
}
