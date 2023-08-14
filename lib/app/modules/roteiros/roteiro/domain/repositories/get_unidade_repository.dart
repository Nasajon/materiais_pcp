import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';

abstract class GetUnidadeRepository {
  Future<List<UnidadeEntity>> call(String search);
}
