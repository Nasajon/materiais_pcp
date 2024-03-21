import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';

abstract class RemoteGetChaoDeFabricaRecursoDatasource {
  Future<List<ChaoDeFabricaRecursoEntity>> call({
    required String search,
    required String grupoDeRecursoId,
    String? ultimoRecursoId,
  });
}
