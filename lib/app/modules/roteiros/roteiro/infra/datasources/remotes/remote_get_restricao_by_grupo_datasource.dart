import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';

abstract class RemoteGetRestricaoByGrupoDatasource {
  Future<List<RestricaoEntity>> call(String grupoDeRestricaoId);
}
