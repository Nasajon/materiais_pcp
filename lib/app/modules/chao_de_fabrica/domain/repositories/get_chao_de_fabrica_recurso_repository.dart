import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_recurso_entity.dart';

abstract class GetChaoDeFabricaRecursoRepository {
  Future<List<ChaoDeFabricaRecursoEntity>> call({required String search, String? ultimoRecursoId});
}
