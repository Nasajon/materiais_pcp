import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';

abstract class GetFichaTecnicaRepository {
  Future<List<FichaTecnicaEntity>> call(String search);
}
