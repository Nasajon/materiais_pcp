import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteProdutoMapper {
  const RemoteProdutoMapper._();

  static ProdutoEntity fromMapToProdutoEntity(Map<String, dynamic> map) {
    return ProdutoEntity(
      id: map['produto'],
      codigo: map['codigo'],
      nome: map['nome'],
      unidade: map['unidade_padrao'] != null ? RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade_padrao']) : null,
    );
  }
}
