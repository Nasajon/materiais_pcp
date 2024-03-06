import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_apontamento_repository.dart';

abstract interface class ChaoDeFabricaApontamentoUsecase {
  Future<void> call(ChaoDeFabricaApontamentoEntity apontamento);
}

class ChaoDeFabricaApontamentoUsecaseImpl implements ChaoDeFabricaApontamentoUsecase {
  final ChaoDeFabricaApontamentoRepository _apontamentoRepository;

  const ChaoDeFabricaApontamentoUsecaseImpl({required ChaoDeFabricaApontamentoRepository apontamentoRepository})
      : _apontamentoRepository = apontamentoRepository;

  @override
  Future<void> call(ChaoDeFabricaApontamentoEntity apontamento) {
    return _apontamentoRepository(apontamento);
  }
}
