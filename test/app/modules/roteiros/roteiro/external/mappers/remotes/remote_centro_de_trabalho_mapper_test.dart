import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_centro_de_trabalho_mapper.dart';

void main() {
  testWidgets('Deve converter um Map em CentroDeTrabalhoEntity', (tester) async {
    final response = RemoteCentroDeTrabalhoMapper.fromMapToCentroDeTrabalho(map);
    expect(response, isA<CentroDeTrabalhoEntity>());
    expect(response.id, '74dcd3fa-036d-4b62-b757-fe4888d354ed');
    expect(response.codigo, '1');
    expect(response.nome, 'Centro 1');
  });
}

const map = <String, dynamic>{
  'centro_de_trabalho': '74dcd3fa-036d-4b62-b757-fe4888d354ed',
  'codigo': '1',
  'nome': 'Centro 1',
};
