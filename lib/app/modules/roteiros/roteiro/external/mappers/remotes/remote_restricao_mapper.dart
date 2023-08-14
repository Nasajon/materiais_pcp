import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';

class RemoteRestricaoMapper {
  const RemoteRestricaoMapper._();

  static RestricaoEntity fromMapToRestricao(Map<String, dynamic> map) {
    return RestricaoEntity(
      id: map['restricao'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
