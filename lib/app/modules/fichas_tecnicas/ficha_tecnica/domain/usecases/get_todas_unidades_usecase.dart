import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/unidade_repository.dart';

abstract class GetTodasUnidadesUsecase {
  Future<List<UnidadeEntity>> call(String search);
}

class GetTodasUnidadesUsecaseImpl implements GetTodasUnidadesUsecase {
  final UnidadeRepository _unidadeRepository;

  const GetTodasUnidadesUsecaseImpl(this._unidadeRepository);

  @override
  Future<List<UnidadeEntity>> call(String search) {
    return _unidadeRepository.getTodasUnidades(search);
  }
}
