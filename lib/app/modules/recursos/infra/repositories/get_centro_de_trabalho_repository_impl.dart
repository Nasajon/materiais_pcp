import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/infra/datasources/remote/remote_get_centro_de_trabalho_datasource.dart';

class GetCentroDeTrabalhoRepositoryImpl implements GetCentroDeTrabalhoRepository {
  final RemoteGetCentroDeTrabalhoDatasource _remoteGetCentroDeTrabalhoDatasource;

  const GetCentroDeTrabalhoRepositoryImpl(this._remoteGetCentroDeTrabalhoDatasource);

  @override
  Future<List<RecursoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId}) {
    return _remoteGetCentroDeTrabalhoDatasource(search: search, ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId);
  }
}
