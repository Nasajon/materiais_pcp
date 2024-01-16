import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/recurso_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/repositories/get_recurso_por_repository.dart';

abstract class GetRecursoPorGrupoUsecase {
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso);
}

class GetRecursoPorGrupoUsecaseImpl implements GetRecursoPorGrupoUsecase {
  final GetRecursoPorGrupoRepository _getRecursoRepository;

  const GetRecursoPorGrupoUsecaseImpl(this._getRecursoRepository);

  @override
  Future<List<RecursoAggregate>> call(String idGrupoDeRecurso) {
    if (idGrupoDeRecurso.isEmpty) {
      throw IdNotFoundRoteiroFailure(errorMessage: translation.messages.erroIdNaoInformado, stackTrace: StackTrace.current);
    }

    return _getRecursoRepository(idGrupoDeRecurso);
  }
}
