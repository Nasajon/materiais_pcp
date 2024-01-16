import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';

abstract class GetMaterialRepository {
  Future<List<MaterialEntity>> call(String idFichaTecnica);
}
