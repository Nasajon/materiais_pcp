import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_centro_de_trabalho_entity.dart';

abstract class RemoteGetChaoDeFabricaCentroDeTrabalhoDatasource {
  Future<List<ChaoDeFabricaCentroDeTrabalhoEntity>> call({required String search, String? ultimoCentroDeTrabalhoId});
}
