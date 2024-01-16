import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/mappers/remotes/remote_ficha_tecnica_produtos_mapper.dart';

void main() {
  test('Deve converter um Map em Ficha tecnica', () async {
    final response = RemoteFichaTecnicaProdutosMapper.fromMapToFichaTecnicaProduto(map, 0);
    expect(response, isA<FichaTecnicaMaterialAggregate>());
    expect(response.id, map['ficha_tecnica_produto']);
    expect(response.codigo.toString(), '1');
    expect(response.quantidade.value, map['quantidade']);
    expect(response.produto, isA<ProdutoEntity>());
    expect(response.unidade, isA<UnidadeEntity>());
  });
}

const map = <String, dynamic>{
  "ficha_tecnica_produto": "aace47ba-c40e-49ae-9fa5-ccef6d5e0f6f",
  "quantidade": 10.0,
  "ficha_tecnica": "21f44ff6-bdcc-44dc-9c81-e9ebe7134dc6",
  "produto": {"produto": "e6aafbcd-2ab7-4c2d-a2c6-0a2899318382", "codigo": "03", "nome": "Leite"},
  "unidade": {"unidade": "fca69f81-ddd6-47ff-ade7-c516488e90ad", "codigo": "LT", "nome": "Litro", "decimais": 2}
};
