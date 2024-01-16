import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/repositories/get_turno_trabalho_repository.dart';

abstract class GetTurnoTrabalhoUsecase {
  Future<List<TurnoTrabalhoEntity>> call();
}

class GetTurnoTrabalhoUsecaseImpl implements GetTurnoTrabalhoUsecase {
  final GetTurnoTrabalhoRepository _getTurnoTrabalhoRepository;

  const GetTurnoTrabalhoUsecaseImpl(this._getTurnoTrabalhoRepository);

  @override
  Future<List<TurnoTrabalhoEntity>> call() {
    return _getTurnoTrabalhoRepository();
  }
}
