import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/tipo_unidade_entity.dart';

abstract class GetTipoUnidadeRepository {
  Future<List<TipoUnidadeEntity>> call(String search);
}
