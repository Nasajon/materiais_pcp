import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/roteiro_repository.dart';

abstract class GetRoteiroRecenteUsecase {
  Future<List<RoteiroEntity>> call();
}

class GetRoteiroRecenteUsecaseImpl implements GetRoteiroRecenteUsecase {
  final RoteiroRepository _roteiroRepository;

  const GetRoteiroRecenteUsecaseImpl(this._roteiroRepository);

  @override
  Future<List<RoteiroEntity>> call() {
    return _roteiroRepository.getRoteiroRecente();
  }
}
