import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';

abstract class RemoteUnidadeDatasource {
  Future<List<UnidadeEntity>> getTodasUnidades(String search);

  Future<Map<String, UnidadeEntity>> getTodasUnidadesPorIds(List<String> ids);

  Future<UnidadeEntity> getUnidadePorId(String id);
}
