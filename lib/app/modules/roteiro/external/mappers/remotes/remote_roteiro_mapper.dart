import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/date_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_ficha_tecnica_mappers.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_operacao_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_produto_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiro/external/mappers/remotes/remote_unidade_mapper.dart';

class RemoteRoteiroMapper {
  const RemoteRoteiroMapper._();

  static RoteiroEntity fromMapToRoteiroEntity(Map<String, dynamic> map) {
    return RoteiroEntity(
      id: map['roteiro'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto_resultante']),
    );
  }

  static RoteiroAggregate fromMapToRoteiroAggregate(Map<String, dynamic> map) {
    return RoteiroAggregate(
      id: map['roteiro'],
      codigo: CodigoVO(map['codigo']),
      descricao: TextVO(map['descricao']),
      inicio: DateVO.date(DateTime.parse(map['inicio'])),
      fim: DateVO.date(DateTime.parse(map['fim'])),
      produto: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto_resultante']),
      fichaTecnica: RemoteFichaTecnicaMapper.fromMapToFichaTecnicaEntity(map['ficha_tecnica']),
      unidade: RemoteUnidadeMapper.fromMapToUnidadeEntity(map['unidade']),
      operacoes: List.from(map['operacoes']).map((map) => RemoteOperacaoMapper.fromMapToOperacaoEntity(map)).toList(),
    );
  }

  static Map<String, dynamic> fromRoteiroToMap(RoteiroAggregate roteiro) {
    final map = {
      'codigo': roteiro.codigo.toText,
      'descricao': roteiro.descricao.value,
      'inicio': roteiro.inicio.dateFormat(format: 'yyyy-MM-dd'),
      'fim': roteiro.fim.dateFormat(format: 'yyyy-MM-dd'),
      'produto_resultante': roteiro.produto.id,
      'ficha_tecnica': roteiro.fichaTecnica.id,
      'unidade': roteiro.unidade.id,
      'operacoes': roteiro.operacoes.map((operacao) => RemoteOperacaoMapper.fromOperacaoToMap(operacao)).toList(),
    };

    if (roteiro.id.isNotEmpty && roteiro != RoteiroAggregate.empty()) {
      map['roteiro'] = roteiro.id;
    }

    return map;
  }
}
