import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/unidade_repository.dart';

abstract class GetUnidadesPorIdsUsecase {
  Future<Map<String, UnidadeEntity>> call(List<String> ids);
}

class GetUnidadesPorIdsUsecaseImpl implements GetUnidadesPorIdsUsecase {
  final UnidadeRepository _unidadeRepository;

  const GetUnidadesPorIdsUsecaseImpl(this._unidadeRepository);

  @override
  Future<Map<String, UnidadeEntity>> call(List<String> ids) {
    return _unidadeRepository.getTodasUnidadesPorIds(ids);
  }
}
