import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';

abstract class RemoteFichaTecnicaDatasource {
  Future<List<FichaTecnicaAggregate>> getFichaTecnicaRecentes();

  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search);

  Future<FichaTecnicaAggregate> getFichaTecnicaPorId(String id);

  Future<FichaTecnicaAggregate> inserirFichaTecnica(FichaTecnicaAggregate fichaTecnica);

  Future<bool> atualizarFichaTecnica(FichaTecnicaAggregate fichaTecnica);

  Future<bool> deletarFichaTecnica(String id);
}
