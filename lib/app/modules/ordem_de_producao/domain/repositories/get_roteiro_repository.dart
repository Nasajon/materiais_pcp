import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';

abstract interface class GetRoteiroRepository {
  Future<List<RoteiroEntity>> call(String produtoId, {String search = '', String ultimoId = ''});
}
