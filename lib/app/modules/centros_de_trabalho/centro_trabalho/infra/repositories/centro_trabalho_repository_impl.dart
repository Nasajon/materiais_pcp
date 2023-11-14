import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/repositories/centro_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/datasources/remotes/remote_centro_trabalho_datasource.dart';

class CentroTrabalhoRepositoryImpl implements CentroTrabalhoRepository {
  final RemoteCentroTrabalhoDatasource _remoteCentroTrabalhoDatasource;

  const CentroTrabalhoRepositoryImpl(this._remoteCentroTrabalhoDatasource);

  @override
  Future<List<CentroTrabalhoAggregate>> getCentroTrabalhoRecentes() {
    return _remoteCentroTrabalhoDatasource.getCentroTrabalhoRecentes();
  }

  @override
  Future<List<CentroTrabalhoAggregate>> getTodosCentroTrabalho(String search) {
    return _remoteCentroTrabalhoDatasource.getTodosCentroTrabalho(search);
  }

  @override
  Future<CentroTrabalhoAggregate> getCentroTrabalhoPorId(String id) {
    return _remoteCentroTrabalhoDatasource.getCentroTrabalhoPorId(id);
  }

  @override
  Future<List<TurnoTrabalhoEntity>> getTurnos(String id, List<String> turnosId) {
    return _remoteCentroTrabalhoDatasource.getTurnos(id, turnosId);
  }

  @override
  Future<CentroTrabalhoAggregate> inserirCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) {
    return _remoteCentroTrabalhoDatasource.inserirCentroTrabalho(centroTrabalho);
  }

  @override
  Future<bool> atualizarCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) {
    return _remoteCentroTrabalhoDatasource.atualizarCentroTrabalho(centroTrabalho);
  }

  @override
  Future<bool> deletarCentroTrabalho(String id) {
    return _remoteCentroTrabalhoDatasource.deletarCentroTrabalho(id);
  }
}
