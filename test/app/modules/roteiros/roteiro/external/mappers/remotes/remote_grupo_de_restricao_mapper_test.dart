import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_grupo_de_restricao_mapper.dart';

void main() {
  testWidgets('Deve converter um Map em GrupoDeRestricaoEntity', (tester) async {
    final response = RemoteGrupoDeRestricaoMapper.fromMapToGrupoDeRestricao(map);
    expect(response, isA<GrupoDeRestricaoEntity>());
    expect(response.id, '101bcda9-bb22-409b-b05d-6d4e84e13899');
    expect(response.codigo, '1');
    expect(response.nome, 'Grupo 1');
  });
}

const map = <String, dynamic>{
  'grupo_de_restricao': '101bcda9-bb22-409b-b05d-6d4e84e13899',
  'codigo': '1',
  'nome': 'Grupo 1',
  'tipo': 'componentes',
};
