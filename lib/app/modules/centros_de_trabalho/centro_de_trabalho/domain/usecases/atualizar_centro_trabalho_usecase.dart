import 'package:pcp_flutter/app/common/pcp_common.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/errors/centro_trabalho_failure.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_de_trabalho/domain/repositories/centro_trabalho_repository.dart';

abstract class AtualizarCentroTrabalhoUsecase {
  Future<bool> call(CentroTrabalhoAggregate centroTrabalho);
}

class AtualizarCentroTrabalhoUsecaseImpl implements AtualizarCentroTrabalhoUsecase {
  final CentroTrabalhoRepository _centroTrabalhoRepository;

  const AtualizarCentroTrabalhoUsecaseImpl(this._centroTrabalhoRepository);

  @override
  Future<bool> call(CentroTrabalhoAggregate centroTrabalho) {
    if (centroTrabalho.id.isEmpty) {
      throw IdNotFoundCentroTrabalhoFailure(errorMessage: translation?.messages.erroIdNaoInformado ?? '');
    }

    return _centroTrabalhoRepository.atualizarCentroTrabalho(centroTrabalho);
  }
}
