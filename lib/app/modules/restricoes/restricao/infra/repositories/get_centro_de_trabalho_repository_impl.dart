import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/entities/restricao_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/repositories/get_centro_de_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/infra/datasources/remote/remote_get_centro_de_trabalho_datasource.dart';

class GetCentroDeTrabalhoRepositoryImpl implements GetCentroDeTrabalhoRepository {
  final RemoteGetCentroDeTrabalhoDatasource _remoteGetCentroDeTrabalhoDatasource;

  const GetCentroDeTrabalhoRepositoryImpl(this._remoteGetCentroDeTrabalhoDatasource);

  @override
  Future<List<RestricaoCentroDeTrabalho>> call({required String search, String? ultimoCentroDeTrabalhoId}) {
    return _remoteGetCentroDeTrabalhoDatasource(search: search, ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId);
  }
}
