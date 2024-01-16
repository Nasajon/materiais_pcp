import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/roteiro_repository.dart';

abstract class GetRoteiroUsecase {
  Future<List<RoteiroEntity>> call(String search);
}

class GetRoteiroUsecaseImpl implements GetRoteiroUsecase {
  final RoteiroRepository _roteiroRepository;

  const GetRoteiroUsecaseImpl(this._roteiroRepository);

  @override
  Future<List<RoteiroEntity>> call(String search) {
    return _roteiroRepository.getRoteiro(search);
  }
}
