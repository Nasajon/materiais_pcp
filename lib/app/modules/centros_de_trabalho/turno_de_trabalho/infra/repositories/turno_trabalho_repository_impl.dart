import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/repositories/turno_trabalho_repository.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/infra/datasources/remote/turno_trabalho_datasource.dart';

class TurnoTrabalhoRepositoryImpl implements TurnoTrabalhoRepository {
  final TurnoTrabalhoDatasource _turnoTrabalhoDatasource;

  const TurnoTrabalhoRepositoryImpl(this._turnoTrabalhoDatasource);

  @override
  Future<List<TurnoTrabalhoAggregate>> getTurnoTrabalhoRecentes() {
    return _turnoTrabalhoDatasource.getTurnoTrabalhoRecentes();
  }

  @override
  Future<TurnoTrabalhoAggregate> getTurnoTrabalhoPorId(String id) {
    return _turnoTrabalhoDatasource.getTurnoTrabalhoPorId(id);
  }

  @override
  Future<TurnoTrabalhoAggregate> inserir(TurnoTrabalhoAggregate turno) {
    return _turnoTrabalhoDatasource.inserir(turno);
  }

  @override
  Future<bool> editar(TurnoTrabalhoAggregate turno) {
    return _turnoTrabalhoDatasource.editar(turno);
  }

  @override
  Future<bool> deletar(String id) {
    return _turnoTrabalhoDatasource.deletar(id);
  }
}
