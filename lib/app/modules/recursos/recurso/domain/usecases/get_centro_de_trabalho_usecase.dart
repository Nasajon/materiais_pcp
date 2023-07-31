import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/repositories/get_centro_de_trabalho_repository.dart';

abstract class GetCentroDeTrabalhoUsecase {
  Future<List<RecursoCentroDeTrabalho>> call();
}

class GetCentroDeTrabalhoUsecaseImpl implements GetCentroDeTrabalhoUsecase {
  final GetCentroDeTrabalhoRepository _getCentroDeTrabalhoRepository;

  const GetCentroDeTrabalhoUsecaseImpl(this._getCentroDeTrabalhoRepository);

  @override
  Future<List<RecursoCentroDeTrabalho>> call() {
    return _getCentroDeTrabalhoRepository();
  }
}
