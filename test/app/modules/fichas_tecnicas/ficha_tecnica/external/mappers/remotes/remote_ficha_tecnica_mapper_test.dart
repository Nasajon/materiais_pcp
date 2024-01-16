import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/mappers/remotes/remote_ficha_tecnica_mapper.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';

void main() {
  test('Deve converter um Map em Ficha tecnica', () async {
    final response = RemoteFichaTecnicaMapper.fromMapToFichaTecnica(map);
    expect(response, isA<FichaTecnicaAggregate>());
    expect(response.id, map['ficha_tecnica']);
    expect(response.codigo.toString(), map['codigo']);
    expect(response.descricao.toString(), map['descricao']);
    expect(response.quantidade.value, map['quantidade']);
    expect(response.produto, isA<ProdutoEntity>());
    expect(response.unidade, isA<UnidadeEntity>());
    expect(response.materiais, isA<List<FichaTecnicaMaterialAggregate>>());
    expect(response.materiais.length, 1);
    expect(response.materiais[0].id, map['produtos'][0]['ficha_tecnica_produto']);
    expect(response.materiais[0].quantidade.value, map['produtos'][0]['quantidade']);
    expect(response.materiais[0].produto, isA<ProdutoEntity>());
    expect(response.materiais[0].unidade, isA<UnidadeEntity>());
  });
}

const map = <String, dynamic>{
  "ficha_tecnica": "21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6",
  "codigo": "01",
  "descricao": "teste",
  "quantidade": 1.0,
  "produtos": [
    {
      "ficha_tecnica_produto": "aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f",
      "quantidade": 10.0,
      "ficha_tecnica": "21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6",
      "produto": {"produto": "e6aafbcd-2ab7-4c2d-a2c6-0a2899318382", "codigo": "03", "nome": "Leite"},
      "unidade": {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2}
    }
  ],
  "produto": {"produto": "0683765b-847e-4a72-8109-f49bcd792518", "codigo": "01", "nome": "Bolo"},
  "unidade": {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2}
};
