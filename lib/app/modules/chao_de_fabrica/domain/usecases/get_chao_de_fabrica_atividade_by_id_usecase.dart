import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/errors/chao_de_fabrica_failure.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';

abstract interface class GetChaoDeFabricaAtividadeByIdUsecase {
  Future<ChaoDeFabricaAtividadeAggregate> call(String atividadeId);
}

class GetChaoDeFabricaAtividadeByIdUsecaseImpl implements GetChaoDeFabricaAtividadeByIdUsecase {
  final ChaoDeFabricaAtividadeRepository _atividadeRepository;

  const GetChaoDeFabricaAtividadeByIdUsecaseImpl({required ChaoDeFabricaAtividadeRepository atividadeRepository})
      : _atividadeRepository = atividadeRepository;

  @override
  Future<ChaoDeFabricaAtividadeAggregate> call(String atividadeId) {
    if (atividadeId.isEmpty) {
      throw IdNotFoundChaoDeFabricaFailure(errorMessage: translation.messages.erroIdNaoInformado);
    }

    return _atividadeRepository.getAtividade(atividadeId);
  }
}
