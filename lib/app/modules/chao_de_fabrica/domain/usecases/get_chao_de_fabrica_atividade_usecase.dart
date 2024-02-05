import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/aggregates/chao_de_fabrica_atividade_aggregate.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/dto/filters/chao_de_fabrica_atividade_filter.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_atividade_repository.dart';

abstract interface class GetChaoDeFabricaAtividadeUsecase {
  Future<List<ChaoDeFabricaAtividadeAggregate>> call(ChaoDeFabricaAtividadeFilter filter);
}

class GetChaoDeFabricaAtividadeUsecaseImpl implements GetChaoDeFabricaAtividadeUsecase {
  final ChaoDeFabricaAtividadeRepository _atividadeRepository;

  const GetChaoDeFabricaAtividadeUsecaseImpl({required ChaoDeFabricaAtividadeRepository atividadeRepository})
      : _atividadeRepository = atividadeRepository;

  @override
  Future<List<ChaoDeFabricaAtividadeAggregate>> call(ChaoDeFabricaAtividadeFilter filter) {
    return _atividadeRepository.getAtividades(filter);
  }
}
