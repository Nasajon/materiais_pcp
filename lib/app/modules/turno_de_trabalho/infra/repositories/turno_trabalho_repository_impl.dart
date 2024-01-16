import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/infra/datasources/remote/remote_turno_trabalho_datasource.dart';

class TurnoTrabalhoRepositoryImpl implements TurnoTrabalhoRepository {
  final RemoteTurnoTrabalhoDatasource _remoteTurnoTrabalhoDatasource;

  const TurnoTrabalhoRepositoryImpl(this._remoteTurnoTrabalhoDatasource);

  @override
  Future<List<TurnoTrabalhoAggregate>> getTurnoTrabalhoRecentes() {
    return _remoteTurnoTrabalhoDatasource.getTurnoTrabalhoRecentes();
  }

  @override
  Future<List<TurnoTrabalhoAggregate>> getTurnosTrabalhos({required String search}) {
    return _remoteTurnoTrabalhoDatasource.getTurnosTrabalhos(search: search);
  }

  @override
  Future<TurnoTrabalhoAggregate> getTurnoTrabalhoPorId(String id) {
    return _remoteTurnoTrabalhoDatasource.getTurnoTrabalhoPorId(id);
  }

  @override
  Future<TurnoTrabalhoAggregate> inserir(TurnoTrabalhoAggregate turno) {
    return _remoteTurnoTrabalhoDatasource.inserir(turno);
  }

  @override
  Future<bool> editar(TurnoTrabalhoAggregate turno) {
    return _remoteTurnoTrabalhoDatasource.editar(turno);
  }

  @override
  Future<bool> deletar(String id) {
    return _remoteTurnoTrabalhoDatasource.deletar(id);
  }
}
