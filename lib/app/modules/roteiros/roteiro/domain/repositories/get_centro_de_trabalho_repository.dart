import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';

abstract class GetCentroDeTrabalhoRepository {
  Future<List<CentroDeTrabalhoEntity>> call(String search);
}
