import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/errors/turno_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';

abstract class DeletarTurnoTrabalhoUsecase {
  Future<bool> call(String id);
}

class DeletarTurnoTrabalhoUsecaseImpl implements DeletarTurnoTrabalhoUsecase {
  final TurnoTrabalhoRepository _turnoTrabalhoRepository;

  const DeletarTurnoTrabalhoUsecaseImpl(this._turnoTrabalhoRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      throw IdNotFoundTurnoTrabalhoFailure();
    }

    return _turnoTrabalhoRepository.deletar(id);
  }
}
