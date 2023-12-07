import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/repositories/ordem_de_producao_repository.dart';

abstract interface class GetOrdemDeProducaoUsecase {
  Future<List<OrdemDeProducaoAggregate>> call({String search = '', String ultimoId = ''});
}

class GetOrdemDeProducaoUsecaseImpl implements GetOrdemDeProducaoUsecase {
  final OrdemDeProducaoRepository _ordemDeProducaoRepository;

  const GetOrdemDeProducaoUsecaseImpl({required OrdemDeProducaoRepository ordemDeProducaoRepository})
      : _ordemDeProducaoRepository = ordemDeProducaoRepository;

  @override
  Future<List<OrdemDeProducaoAggregate>> call({String search = '', String ultimoId = ''}) {
    return _ordemDeProducaoRepository.getOrdens(search: search, ultimoId: ultimoId);
  }
}
