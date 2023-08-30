import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/material_entity.dart';

abstract class RemoteGetMaterialDatasource {
  Future<List<MaterialEntity>> call(String fichaTecnicaId);
}
