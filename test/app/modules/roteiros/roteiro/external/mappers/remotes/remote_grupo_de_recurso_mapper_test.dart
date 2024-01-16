import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/grupo_de_recurso_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_grupo_de_recurso_mapper.dart';

void main() {
  test('Deve converter um Map em GrupoDeRecursoEntity', () async {
    final response = RemoteGrupoDeRecursoMapper.fromMapToGrupoDeRecursoEntity(map);
    expect(response, isA<GrupoDeRecursoEntity>());
    expect(response.id, '74dcd3fa-036d-4b62-b757-fe4888d354ed');
    expect(response.codigo, '1');
    expect(response.nome, 'Teste 1');
  });
}

const map = <String, dynamic>{
  'grupo_de_recurso': '74dcd3fa-036d-4b62-b757-fe4888d354ed',
  'codigo': '1',
  'nome': 'Teste 1',
};
