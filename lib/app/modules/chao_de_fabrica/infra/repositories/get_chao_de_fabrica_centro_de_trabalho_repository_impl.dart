import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/repositories/get_chao_de_fabrica_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/datasources/remote/remote_get_chao_de_fabrica_centro_de_trabalho_datasource.dart';

class GetChaoDeFabricaCentroDeTrabalhoRepositoryImpl implements GetChaoDeFabricaCentroDeTrabalhoRepository {
  final RemoteGetChaoDeFabricaCentroDeTrabalhoDatasource _remoteCentroDeTrabalhoDatasource;

  const GetChaoDeFabricaCentroDeTrabalhoRepositoryImpl({
    required RemoteGetChaoDeFabricaCentroDeTrabalhoDatasource remoteCentroDeTrabalhoDatasource,
  }) : _remoteCentroDeTrabalhoDatasource = remoteCentroDeTrabalhoDatasource;

  @override
  Future<List<ChaoDeFabricaCentroDeTrabalhoEntity>> call({required String search, String? ultimoCentroDeTrabalhoId}) {
    return _remoteCentroDeTrabalhoDatasource(
      search: search,
      ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId,
    );
  }
}
