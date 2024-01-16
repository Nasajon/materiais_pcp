import 'package:pcp_flutter/app/modules/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_ficha_tecnica_repository.dart';

abstract class GetFichaTecnicaUsecase {
  Future<List<FichaTecnicaEntity>> call(String search);
}

class GetFichaTecnicaUsecaseImpl implements GetFichaTecnicaUsecase {
  final GetFichaTecnicaRepository _getFichaTecnicaRepository;

  const GetFichaTecnicaUsecaseImpl(this._getFichaTecnicaRepository);

  @override
  Future<List<FichaTecnicaEntity>> call(String search) {
    return _getFichaTecnicaRepository(search);
  }
}
