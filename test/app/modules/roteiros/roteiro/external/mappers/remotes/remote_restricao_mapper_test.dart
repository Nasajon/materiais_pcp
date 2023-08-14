import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/restricao_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_restricao_mapper.dart';

void main() {
  testWidgets('Deve converter um Map em RestricaoEntity', (tester) async {
    final response = RemoteRestricaoMapper.fromMapToRestricao(map);
    expect(response, isA<RestricaoEntity>());
    expect(response.id, '7526cb27-31ec-42a0-8d32-df92a8d5bbaa');
    expect(response.codigo, '1');
    expect(response.nome, 'Restricao 1');
  });
}

const map = <String, dynamic>{
  'restricao': '7526cb27-31ec-42a0-8d32-df92a8d5bbaa',
  'codigo': '1',
  'nome': 'Restricao 1',
};
