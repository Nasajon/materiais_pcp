import 'package:pcp_flutter/app/modules/roteiro/domain/entities/ficha_tecnica_entity.dart';

abstract class RemoteGetFichaTecnicaDatasource {
  Future<List<FichaTecnicaEntity>> call(String search);
}
