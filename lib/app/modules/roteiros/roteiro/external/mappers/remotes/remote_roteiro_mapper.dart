import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_ficha_tecnica_mappers.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_operacao_mapper.dart';

class RemoteRoteiroMapper {
  const RemoteRoteiroMapper._();

  static RoteiroEntity fromMapToRoteiroEntity(Map<String, dynamic> map) {
    return RoteiroEntity(
      id: map['roteiro'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      produto: ProdutoEntity.id(map['produto_resultante']),
    );
  }

  static RoteiroAggregate fromMapToRoteiroAggregate(Map<String, dynamic> map) {
    return RoteiroAggregate(
      id: map['roteiro'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      inicio: DateVO(map['inicio']),
      fim: DateVO(map['fim']),
      produto: ProdutoEntity.id(map['produto_resultante']),
      fichaTecnica: RemoteFichaTecnicaMapper.fromMapToFichaTecnicaEntity(map['ficha_tecnica']),
      unidade: UnidadeEntity.id(map['unidade']),
      operacoes: List.from(map['operacoes']).map((map) => RemoteOperacaoMapper.fromMapToOperacaoEntity(map)).toList(),
    );
  }

  static Map<String, dynamic> fromRoteiroToMap(RoteiroAggregate roteiro) {
    return {
      'roteiro': roteiro.id,
      'codigo': roteiro.codigo,
      'descricao': roteiro.descricao,
      'inicio': roteiro.inicio.dateFormat(format: 'yyyy-MM-dd'),
      'fim': roteiro.fim.dateFormat(format: 'yyyy-MM-dd'),
      'produto_resultante': roteiro.produto.id,
      'ficha_tecnica': roteiro.fichaTecnica.id,
      'unidade': roteiro.unidade.id,
      'operacoes': roteiro.operacoes.map((operacao) => RemoteOperacaoMapper.fromOperacaoToMap(operacao)).toList(),
    };
  }
}
