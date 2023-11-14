import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/entities/turno_trabalho_entity.dart';

abstract class RemoteCentroTrabalhoDatasource {
  Future<List<CentroTrabalhoAggregate>> getCentroTrabalhoRecentes();

  Future<List<CentroTrabalhoAggregate>> getTodosCentroTrabalho(String search);

  Future<CentroTrabalhoAggregate> getCentroTrabalhoPorId(String id);

  Future<List<TurnoTrabalhoEntity>> getTurnos(String id, List<String> turnosId);

  Future<CentroTrabalhoAggregate> inserirCentroTrabalho(CentroTrabalhoAggregate centroTrabalho);

  Future<bool> atualizarCentroTrabalho(CentroTrabalhoAggregate centroTrabalho);

  Future<bool> deletarCentroTrabalho(String id);
}
