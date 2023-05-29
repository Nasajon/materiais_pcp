import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/restricao_repository.dart';

abstract class UpdateRestricaoUsecase {
  Future<bool> call(RestricaoAggregate restricao);
}

class UpdateRestricaoUsecaseImpl implements UpdateRestricaoUsecase {
  final RestricaoRepository _restricaoRepository;

  const UpdateRestricaoUsecaseImpl(this._restricaoRepository);

  @override
  Future<bool> call(RestricaoAggregate restricao) {
    return _restricaoRepository.update(restricao);
  }
}
