import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_unidade_repository.dart';

abstract class GetUnidadeUsecase {
  Future<List<UnidadeEntity>> call(String search);
}

class GetUnidadeUsecaseImpl implements GetUnidadeUsecase {
  final GetUnidadeRepository _getUnidadeRepository;

  const GetUnidadeUsecaseImpl(this._getUnidadeRepository);

  @override
  Future<List<UnidadeEntity>> call(String search) {
    return _getUnidadeRepository(search);
  }
}
