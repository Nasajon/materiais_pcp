import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';

abstract interface class DeletarOrdemDeProducaoUsecase {
  Future<bool> call(String ordemDeProducaoId);
}

class DeletarOrdemDeProducaoUsecaseImpl implements DeletarOrdemDeProducaoUsecase {
  final OrdemDeProducaoRepository _ordemDeProducaoRepository;

  const DeletarOrdemDeProducaoUsecaseImpl(this._ordemDeProducaoRepository);

  @override
  Future<bool> call(String ordemDeProducaoId) {
    if (ordemDeProducaoId.isEmpty) {
      throw IdNotFoundOrdemDeProducaoFailure(
        errorMessage: translation.messages.erroIdNaoInformado,
        stackTrace: StackTrace.current,
      );
    }

    return _ordemDeProducaoRepository.deletar(ordemDeProducaoId);
  }
}
