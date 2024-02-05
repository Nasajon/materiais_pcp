import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';

abstract interface class ChaoDeFabricaIniciarPreparacaoUsecase {
  Future<ChaoDeFabricaAtividadeAggregate> call(ChaoDeFabricaAtividadeAggregate atividade);
}

class ChaoDeFabricaIniciarPreparacaoUsecaseImpl implements ChaoDeFabricaIniciarPreparacaoUsecase {
  final ChaoDeFabricaAtividadeRepository _atividadeRepository;

  const ChaoDeFabricaIniciarPreparacaoUsecaseImpl({required ChaoDeFabricaAtividadeRepository atividadeRepository})
      : _atividadeRepository = atividadeRepository;

  @override
  Future<ChaoDeFabricaAtividadeAggregate> call(ChaoDeFabricaAtividadeAggregate atividade) {
    if (atividade.status != AtividadeStatusEnum.aberta) {
      // TODO: Adicionar que erro quando a atividade não está aberta
    }

    return _atividadeRepository.iniciarPreparacao(atividade);
  }
}
