import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/repositories/get_recurso_repository.dart';

abstract class GetRecursoUsecase {
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso);
}

class GetRecursoUsecaseImpl implements GetRecursoUsecase {
  final GetRecursoRepository _getRecursoRepository;

  const GetRecursoUsecaseImpl(this._getRecursoRepository);

  @override
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso) {
    if (idGrupoDeRecurso.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _getRecursoRepository(idGrupoDeRecurso);
  }
}
