import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_restricao_by_grupo_repository.dart';

abstract class GetRestricaoByGrupoUsecase {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}

class GetRestricaoByGrupoUsecaseImpl implements GetRestricaoByGrupoUsecase {
  final GetRestricaoByGrupoRepository _getRestricaoByGrupoRepository;

  const GetRestricaoByGrupoUsecaseImpl(this._getRestricaoByGrupoRepository);

  @override
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId) {
    if (grupoDeRestricaoId.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _getRestricaoByGrupoRepository(grupoDeRestricaoId);
  }
}
