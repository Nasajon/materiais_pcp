import 'package:pcp_flutter/app/core/modules/domain/enums/atividade_status_enum%20copy.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';

abstract interface class ChaoDeFabricaIniciarAtividadeUsecase {
  Future<ChaoDeFabricaAtividadeAggregate> call(ChaoDeFabricaAtividadeAggregate atividade);
}

class ChaoDeFabricaIniciarAtividadeUsecaseImpl implements ChaoDeFabricaIniciarAtividadeUsecase {
  final ChaoDeFabricaAtividadeRepository _atividadeRepository;

  const ChaoDeFabricaIniciarAtividadeUsecaseImpl({required ChaoDeFabricaAtividadeRepository atividadeRepository})
      : _atividadeRepository = atividadeRepository;

  @override
  Future<ChaoDeFabricaAtividadeAggregate> call(ChaoDeFabricaAtividadeAggregate atividade) {
    if (atividade.status != AtividadeStatusEnum.aberta || atividade.status != AtividadeStatusEnum.emPreparacao) {
      // TODO: Adicionar que erro quando a atividade não está aberta
    }

    return _atividadeRepository.iniciarAtividade(atividade);
  }
}
