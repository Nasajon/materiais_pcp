import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';

abstract class GetFichaTecnicaRecenteUsecase {
  Future<List<FichaTecnicaAggregate>> call();
}

class GetFichaTecnicaRecenteUsecaseImpl implements GetFichaTecnicaRecenteUsecase {
  final FichaTecnicaRepository _turnoTrabalhoRepository;

  const GetFichaTecnicaRecenteUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<List<FichaTecnicaAggregate>> call() {
    return _turnoTrabalhoRepository.getFichaTecnicaRecentes();
  }
}
