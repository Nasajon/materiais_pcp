import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/restricao_repository.dart';

abstract class InsertRestricaoUsecase {
  Future<RestricaoAggregate> call(RestricaoAggregate restricao);
}

class InsertRestricaoUsecaseImpl implements InsertRestricaoUsecase {
  final RestricaoRepository _restricaoRepository;

  const InsertRestricaoUsecaseImpl(this._restricaoRepository);

  @override
  Future<RestricaoAggregate> call(RestricaoAggregate restricao) {
    return _restricaoRepository.insert(restricao);
  }
}
