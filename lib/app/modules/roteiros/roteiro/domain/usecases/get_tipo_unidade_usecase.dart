import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_tipo_unidade_repository.dart';

abstract class GetTipoUnidadeUsecase {
  Future<List<TipoUnidadeEntity>> call(String search);
}

class GetTipoUnidadeUsecaseImpl implements GetTipoUnidadeUsecase {
  final GetTipoUnidadeRepository _getTipoUnidadeRepository;

  const GetTipoUnidadeUsecaseImpl(this._getTipoUnidadeRepository);

  @override
  Future<List<TipoUnidadeEntity>> call(String search) {
    return _getTipoUnidadeRepository(search);
  }
}
