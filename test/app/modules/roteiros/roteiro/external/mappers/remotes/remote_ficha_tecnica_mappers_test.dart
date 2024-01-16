import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_ficha_tecnica_mappers.dart';

void main() {
  test('Deve converter um Map em FinchaTecnicaEntity', () async {
    final response = RemoteFichaTecnicaMapper.fromMapToFichaTecnicaEntity(map);
    expect(response, isA<FichaTecnicaEntity>());
    expect(response.id, '74dcd3fa-036d-4b62-b757-fe4888d354ed');
    expect(response.codigo, '1');
    expect(response.descricao, 'Teste 1');
  });
}

const map = <String, dynamic>{
  'ficha_tecnica': '74dcd3fa-036d-4b62-b757-fe4888d354ed',
  'codigo': '1',
  'descricao': 'Teste 1',
};
