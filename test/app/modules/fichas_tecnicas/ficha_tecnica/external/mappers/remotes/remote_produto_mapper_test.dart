import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/external/mappers/remotes/remote_produto_mapper.dart';

void main() {
  test('Deve converter um Map em Ficha tecnica', () async {
    final response = RemoteProdutoMapper.fromMapToProduto(map);
    expect(response, isA<ProdutoEntity>());
    expect(response.id, map['produto']);
    expect(response.codigo, map['codigo']);
    expect(response.nome, map['nome']);
  });
}

const map = <String, dynamic>{"produto": "0683765b-847e-4a72-8109-f49bcd792518", "codigo": "01", "nome": "Bolo"};
