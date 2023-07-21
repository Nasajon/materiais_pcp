import 'package:pcp_flutter/app/common/pcp_common.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class DeletarCentroTrabalhoUsecase {
  Future<bool> call(String id);
}

class DeletarCentroTrabalhoUsecaseImpl implements DeletarCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const DeletarCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<bool> call(String id) {
    if (id.isEmpty) {
      throw IdNotFoundCentroTrabalhoFailure(errorMessage: translation?.messages.erroIdNaoInformado ?? '');
    }

    return _centroTrabalhoRepository.deletarCentroTrabalho(id);
  }
}