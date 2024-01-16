import 'package:pcp_flutter/app/modules/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_centro_de_trabalho_repository.dart';

abstract class GetCentroDeTrabalhoUsecase {
  Future<List<CentroDeTrabalhoEntity>> call(String search);
}

class GetCentroDeTrabalhoUsecaseImpl implements GetCentroDeTrabalhoUsecase {
  final GetCentroDeTrabalhoRepository _getCentroDeTrabalhoRepository;

  const GetCentroDeTrabalhoUsecaseImpl(this._getCentroDeTrabalhoRepository);

  @override
  Future<List<CentroDeTrabalhoEntity>> call(String search) {
    return _getCentroDeTrabalhoRepository(search);
  }
}
