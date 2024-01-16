import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/mappers/remotes/remote_unidade_mapper.dart';

void main() {
  test('Deve converter um Map em Ficha tecnica', () async {
    final response = RemoteUnidadeMapper.fromMapToUnidade(map);
    expect(response, isA<UnidadeEntity>());
    expect(response.id, map['unidade']);
    expect(response.codigo, map['codigo']);
    expect(response.nome, map['nome']);
    expect(response.decimais, map['decimais']);
  });
}

const map = <String, dynamic>{"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2};
