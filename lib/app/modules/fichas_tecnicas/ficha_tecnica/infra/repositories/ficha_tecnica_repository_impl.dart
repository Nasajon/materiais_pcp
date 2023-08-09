import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/repositories/ficha_tecnica_repository.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/infra/datasources/remotes/remote_ficha_tecnica_datasource.dart';

class FichaTecnicaRepositoryImpl implements FichaTecnicaRepository {
  final RemoteFichaTecnicaDatasource remoteFichaTecnicaDatasource;

  FichaTecnicaRepositoryImpl(
    this.remoteFichaTecnicaDatasource,
  );

  @override
  Future<bool> atualizarFichaTecnica(FichaTecnicaAggregate fichaTecnica) {
    return remoteFichaTecnicaDatasource.atualizarFichaTecnica(fichaTecnica);
  }

  @override
  Future<bool> deletarFichaTecnica(String id) {
    return remoteFichaTecnicaDatasource.deletarFichaTecnica(id);
  }

  @override
  Future<FichaTecnicaAggregate> getFichaTecnicaPorId(String id) async {
    return remoteFichaTecnicaDatasource.getFichaTecnicaPorId(id);
  }

  @override
  Future<List<FichaTecnicaAggregate>> getFichaTecnicaRecentes() async {
    return remoteFichaTecnicaDatasource.getFichaTecnicaRecentes();
  }

  @override
  Future<List<FichaTecnicaAggregate>> getTodosFichaTecnica(String search) async {
    return remoteFichaTecnicaDatasource.getTodosFichaTecnica(search);
  }

  @override
  Future<FichaTecnicaAggregate> inserirFichaTecnica(FichaTecnicaAggregate fichaTecnica) {
    return remoteFichaTecnicaDatasource.inserirFichaTecnica(fichaTecnica);
  }
}
