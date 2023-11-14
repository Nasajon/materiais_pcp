import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/unidade.dart';

class RemoteUnidadeMapper {
  const RemoteUnidadeMapper._();

  static UnidadeEntity fromMapToUnidade(Map<String, dynamic> map) {
    return UnidadeEntity(
      id: map['unidade'],
      codigo: map['codigo'],
      nome: map['nome'],
      decimais: map.containsKey('decimais') ? map['decimais'] ?? 0 : 0,
    );
  }

  static Map<String, dynamic> fromUnidadeToMap(UnidadeEntity unidade) {
    return {
      'unidade': unidade.id,
      'codigo': unidade.codigo,
      'nome': unidade.nome,
      'decimais': unidade.decimais,
    };
  }
}
