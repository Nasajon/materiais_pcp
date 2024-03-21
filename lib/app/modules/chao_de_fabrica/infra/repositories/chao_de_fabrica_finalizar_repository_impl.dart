import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/chao_de_fabrica_finalizar_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_chao_de_fabrica_finalizar_datasource.dart';

class ChaoDeFabricaFinalizarRepositoryImpl implements ChaoDeFabricaFinalizarRepository {
  final RemoteChaoDeFabricaFinalizarDatasource _finalizarDatasource;

  const ChaoDeFabricaFinalizarRepositoryImpl({required RemoteChaoDeFabricaFinalizarDatasource finalizarDatasource})
      : _finalizarDatasource = finalizarDatasource;

  @override
  Future<void> call(ChaoDeFabricaFinalizarEntity finalizar) {
    return _finalizarDatasource(finalizar);
  }
}
