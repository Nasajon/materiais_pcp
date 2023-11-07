import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

abstract class RemoteGetUnidadeDatasource {
  Future<List<UnidadeEntity>> call(String search);
}
