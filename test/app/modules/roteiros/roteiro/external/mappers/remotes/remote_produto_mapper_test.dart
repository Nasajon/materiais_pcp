import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_produto_mapper.dart';

void main() {
  testWidgets('Deve converter um Map em CentroDeTrabalhoEntity', (tester) async {
    final response = RemoteProdutoMapper.fromMapToProdutoEntity(map);
    expect(response, isA<ProdutoEntity>());
    expect(response.id, '358c2657-00e1-48dc-8beb-5175d691bc30');
    expect(response.codigo, '003');
    expect(response.nome, 'Doritos Queijo Nacho');
  });
}

const map = <String, dynamic>{
  'id': '358c2657-00e1-48dc-8beb-5175d691bc30',
  'codigo': '003',
  'especificacao': 'Doritos Queijo Nacho',
};
