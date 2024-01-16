import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';

abstract class UnidadeRepository {
  Future<List<UnidadeEntity>> getTodasUnidades(String search);

  Future<Map<String, UnidadeEntity>> getTodasUnidadesPorIds(List<String> ids);
}
