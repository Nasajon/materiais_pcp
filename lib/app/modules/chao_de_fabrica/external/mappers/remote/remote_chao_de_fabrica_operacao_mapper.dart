import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_operacao_entity.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/mappers/remote/remote_chao_de_fabrica_produto_mapper.dart';

class RemoteChaoDeFabricaOperacaoMapper {
  const RemoteChaoDeFabricaOperacaoMapper._();

  static ChaoDeFabricaOperacaoEntity fromMapToOperacaoEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaOperacaoEntity(
      id: map['operacao'],
      operacaoOrdemId: map['operacao_ordem'],
      codigo: map['codigo'],
      nome: map['nome'],
      produtoResultante:
          map['produto_resultante'] != null ? RemoteChaoDeFabricaProdutoMapper.fromMapToProdutoEntity(map['produto_resultante']) : null,
    );
  }
}
