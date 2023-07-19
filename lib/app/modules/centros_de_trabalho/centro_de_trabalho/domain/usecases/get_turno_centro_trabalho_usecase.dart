import 'package:pcp_flutter/app/common/pcp_common.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class GetTurnoCentroTrabalhoUsecase {
  Future<List<TurnoTrabalhoEntity>> call(String id, List<String> turnosId);
}

class GetTurnoCentroTrabalhoUsecaseImpl implements GetTurnoCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const GetTurnoCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<List<TurnoTrabalhoEntity>> call(String id, List<String> turnosId) {
    if (id.isEmpty) {
      throw IdNotFoundCentroTrabalhoFailure(errorMessage: translation?.messages.erroIdNaoInformado ?? '');
    }

    return _centroTrabalhoRepository.getTurnos(id, turnosId);
  }
}
