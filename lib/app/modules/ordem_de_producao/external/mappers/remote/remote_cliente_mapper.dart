import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/cliente_entity.dart';

class RemoteClienteMapper {
  const RemoteClienteMapper._();

  static ClienteEntity fromMapToCliente(Map<String, dynamic> map) {
    return ClienteEntity(
      id: map['id'],
      codigo: map['pessoa'],
      nome: map['nome'],
    );
  }
}
