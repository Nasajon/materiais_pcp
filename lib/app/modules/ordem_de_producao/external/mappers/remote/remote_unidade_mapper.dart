import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/unidade_entity.dart';

class RemoteUnidadeMapper {
  const RemoteUnidadeMapper._();

  static UnidadeEntity fromMapToUnidadeEntity(Map<String, dynamic> map) {
    return UnidadeEntity(
      id: map['unidade'],
      codigo: map['codigo'],
      nome: map['nome'],
      decimal: map['decimais'] ?? 0,
    );
  }
}
