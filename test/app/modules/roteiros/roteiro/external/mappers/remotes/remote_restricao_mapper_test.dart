import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_restricao_mapper.dart';

void main() {
  test('Deve converter um Map em RestricaoAggregate', () async {
    final response = RemoteRestricaoMapper.fromMapToRestricao(map);
    expect(response, isA<RestricaoAggregate>());
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
