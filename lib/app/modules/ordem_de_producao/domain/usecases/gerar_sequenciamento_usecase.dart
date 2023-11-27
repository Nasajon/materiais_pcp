import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/sequenciamento_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/dto/sequenciamento_dto.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/sequenciamento_repository.dart';

abstract interface class GerarSequenciamentoUsecase {
  Future<SequenciamentoAggregate> call(SequenciamentoDTO sequenciamento);
}

class GerarSequenciamentoUsecaseImpl implements GerarSequenciamentoUsecase {
  final SequenciamentoRepository _sequenciamentoRepository;

  const GerarSequenciamentoUsecaseImpl(this._sequenciamentoRepository);

  @override
  Future<SequenciamentoAggregate> call(SequenciamentoDTO sequenciamento) {
    if (sequenciamento.ordensIds.isEmpty) {
      // TODO: Criar erro quando não tiver ids das ordens para o sequenciamento
    }

    if (sequenciamento.recursosIds.isEmpty) {
      // TODO: Criar erro quando não tiver ids das recursos para o sequenciamento
    }

    return _sequenciamentoRepository.gerarSequencimaneto(sequenciamento);
  }
}
