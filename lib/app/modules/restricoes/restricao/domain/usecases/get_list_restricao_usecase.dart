import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/restricao_repository.dart';

abstract class GetListRestricaoUsecase {
  Future<List<RestricaoAggregate>> call([String? search]);
}

class GetListRestricaoUsecaseImpl implements GetListRestricaoUsecase {
  final RestricaoRepository _restricaoRepository;

  const GetListRestricaoUsecaseImpl(this._restricaoRepository);

  @override
  Future<List<RestricaoAggregate>> call([String? search]) {
    return _restricaoRepository.getList(search);
  }
}
