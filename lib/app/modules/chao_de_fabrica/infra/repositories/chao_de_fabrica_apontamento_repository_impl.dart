import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_apontamento_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_apontamento_datasource.dart';

class ChaoDeFabricaApontamentoRepositoryImpl implements ChaoDeFabricaApontamentoRepository {
  final RemoteChaoDeFabricaApontamentoDatasource _apontamentoDatasource;

  const ChaoDeFabricaApontamentoRepositoryImpl({required RemoteChaoDeFabricaApontamentoDatasource apontamentoDatasource})
      : _apontamentoDatasource = apontamentoDatasource;

  @override
  Future<void> call(ChaoDeFabricaApontamentoEntity apontamento) {
    return _apontamentoDatasource(apontamento);
  }
}
