import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/double_vo.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/aggregates/ordem_de_producao_aggregate.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/origem_ordem_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/enums/prioridade_enum.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_cliente_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/external/mappers/remote/remote_roteiro_mapper.dart';

class RemoteOrdemDeProducaoMapper {
  const RemoteOrdemDeProducaoMapper._();

  static OrdemDeProducaoAggregate fromMapToOrdemDeProducaoAggregate(Map<String, dynamic> map) {
    return OrdemDeProducaoAggregate(
      id: map['ordem_de_producao'],
      codigo: CodigoVO.text(map['codigo']),
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto']),
      cliente: map['cliente'] != null ? RemoteClienteMapper.fromMapToCliente(map['cliente']) : null,
      roteiro: RemoteRoteiroMapper.fromMapToRoteiroEntity(map['roteiro']),
      quantidade: DoubleVO(map['quantidade']),
      previsaoDeEntrega: DateVO.date(DateTime.parse(map['fim'])),
      prioridade: PrioridadeEnum.select(map['prioridade']),
      origem: OrigemOrdemEnum.select(map['origem']),
    );
  }

  static Map<String, dynamic> fromOrdemDeProducaoToMap(OrdemDeProducaoAggregate ordem) {
    final map = <String, dynamic>{
      'codigo': ordem.codigo.toText,
      'produto': ordem.produto.id,
      'cliente': ordem.cliente?.id,
      'roteiro': ordem.roteiro.id,
      'quantidade': ordem.quantidade.value,
      'fim': ordem.previsaoDeEntrega.dateFormat(format: 'yyyy-MM-dd'),
      'prioridade': ordem.prioridade.code,
      'origem': ordem.origem.code,
    };

    if (ordem.id.isNotEmpty) {
      map['ordem_de_producao'] = ordem.id;
    }

    return map;
  }
}
