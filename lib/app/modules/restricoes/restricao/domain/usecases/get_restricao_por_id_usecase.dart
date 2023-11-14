import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/restricao_repository.dart';

abstract class GetRestricaoPorIdUsecase {
  Future<RestricaoAggregate> call(String id);
}

class GetRestricaoPorIdUsecaseImpl implements GetRestricaoPorIdUsecase {
  final RestricaoRepository _restricaoRepository;

  const GetRestricaoPorIdUsecaseImpl(this._restricaoRepository);

  @override
  Future<RestricaoAggregate> call(String id) {
    if (id.isEmpty) {}

    return _restricaoRepository.getRestricaoPorId(id);
  }
}
