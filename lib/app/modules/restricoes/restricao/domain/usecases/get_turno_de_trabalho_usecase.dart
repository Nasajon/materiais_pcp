import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/turno_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/error/restricao_failure.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/get_turno_de_trabalho_repository.dart';

abstract interface class GetTurnoDeTrabalhoUsecase {
  Future<List<TurnoDeTrabalhoEntity>> call(String centroDeTrabalhoId, {required String search, String? ultimoTurnoTrabalhoId});
}

class GetTurnoDeTrabalhoUsecaseImpl implements GetTurnoDeTrabalhoUsecase {
  final GetTurnoDeTrabalhoRepository _getTurnoDeTrabalhoRepository;

  const GetTurnoDeTrabalhoUsecaseImpl(this._getTurnoDeTrabalhoRepository);

  @override
  Future<List<TurnoDeTrabalhoEntity>> call(String centroDeTrabalhoId, {required String search, String? ultimoTurnoTrabalhoId}) {
    if (centroDeTrabalhoId.isEmpty) {
      throw RestricaoInvalidCentroDeTrabalhoIdError(
        errorMessage: translation.messages.erroIdNaoInformado,
        stackTrace: StackTrace.current,
      );
    }

    return _getTurnoDeTrabalhoRepository(centroDeTrabalhoId, search: search, ultimoTurnoTrabalhoId: ultimoTurnoTrabalhoId);
  }
}
