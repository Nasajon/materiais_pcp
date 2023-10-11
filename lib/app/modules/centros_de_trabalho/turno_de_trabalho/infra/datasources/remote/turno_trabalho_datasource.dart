import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';

abstract class TurnoTrabalhoDatasource {
  Future<List<TurnoTrabalhoAggregate>> getTurnoTrabalhoRecentes();
  Future<List<TurnoTrabalhoAggregate>> getTurnosTrabalhos({required String search});
  Future<TurnoTrabalhoAggregate> getTurnoTrabalhoPorId(String id);
  Future<TurnoTrabalhoAggregate> inserir(TurnoTrabalhoAggregate turno);
  Future<bool> editar(TurnoTrabalhoAggregate turno);
  Future<bool> deletar(String id);
}
