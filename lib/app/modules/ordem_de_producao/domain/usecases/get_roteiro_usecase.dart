import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/errors/ordem_de_producao_failure.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/get_roteiro_repository.dart';

abstract interface class GetRoteiroUsecase {
  Future<List<RoteiroEntity>> call(String produtoId, {String search = '', String ultimoId = ''});
}

class GetRoteiroUsecaseImpl implements GetRoteiroUsecase {
  final GetRoteiroRepository _getRoteiroRepository;

  const GetRoteiroUsecaseImpl(this._getRoteiroRepository);

  @override
  Future<List<RoteiroEntity>> call(String produtoId, {String search = '', String ultimoId = ''}) async {
    if (produtoId.isEmpty) {
      throw InvalidOrdemDeProducaoFailure(errorMessage: translation.messages.erroSelecioneUmProdutoAntes);
    }

    final response = await _getRoteiroRepository(produtoId, search: search, ultimoId: ultimoId);

    if (response.isEmpty) {
      throw InvalidOrdemDeProducaoFailure(errorMessage: translation.messages.erroNaoHaRoteiroParaProdutoSelecionado);
    }

    return response;
  }
}
