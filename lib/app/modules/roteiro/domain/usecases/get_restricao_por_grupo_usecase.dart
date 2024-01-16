import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_restricao_por_grupo_repository.dart';

abstract class GetRestricaoPorGrupoUsecase {
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId);
}

class GetRestricaoPorGrupoUsecaseImpl implements GetRestricaoPorGrupoUsecase {
  final GetRestricaoPorGrupoRepository _getRestricaoPorGrupoRepository;

  const GetRestricaoPorGrupoUsecaseImpl(this._getRestricaoPorGrupoRepository);

  @override
  Future<List<RestricaoAggregate>> call(String grupoDeRestricaoId) {
    if (grupoDeRestricaoId.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _getRestricaoPorGrupoRepository(grupoDeRestricaoId);
  }
}
