import 'package:pcp_flutter/app/core/modules/domain/value_object/time_vo.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/operacao_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/enums/medicao_tempo_enum.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_centro_de_trabalho_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_material_mapper.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/mappers/remotes/remote_produto_mapper.dart';

class RemoteOperacaoMapper {
  const RemoteOperacaoMapper._();

  static OperacaoAggregate fromMapToOperacaoEntity(Map<String, dynamic> map) {
    return OperacaoAggregate(
      id: map['operacao'],
      ordem: map['ordem'],
      nome: map['nome'],
      razaoConversao: map['razao_conversao'],
      preparacao: TimeVO(map['preparacao']),
      execucao: TimeVO(map['execucao']),
      produtoResultante: RemoteProdutoMapper.fromMapToProdutoEntity(map['produto_resultante']),
      medicaoTempo: MedicaoTempoEnum.selectByValue(map['medicao_tempo']),
      unidade: UnidadeEntity.id(map['unidade']),
      centroDeTrabalho: RemoteCentroDeTrabalhoMapper.fromMapToCentroDeTrabalho(map['centro_de_trabalho']),
      materiais: List.from(map['produtos']).map((map) => RemoteMaterialMapper.fromMapToMaterial(map)).toList(),
      gruposDeRecurso:
          List.from(map['grupos_recursos']).map((map) => RemoteGrupoDeRecursoMapper.fromMapToGrupoDeRecursoAggragate(map)).toList(),
    );
  }

  static Map<String, dynamic> fromOperacaoToMap(OperacaoAggregate operacao) {
    return {
      'operacao': operacao.id,
      'ordem': operacao.ordem,
      'nome': operacao.nome,
      'razao_conversao': operacao.razaoConversao,
      'preparacao': operacao.preparacao.timeFormat(shouldAddSeconds: true),
      'execucao': operacao.execucao.timeFormat(shouldAddSeconds: true),
      'produto_resultante': operacao.produtoResultante?.id,
      'medicao_tempo': operacao.medicaoTempo != null ? operacao.medicaoTempo!.value : '',
      'unidade': operacao.unidade.id,
      'centro_de_trabalho': operacao.centroDeTrabalho.id,
      'produtos': operacao.materiais.map((material) => RemoteMaterialMapper.fromMaterialToMap(material)).toList(),
      'grupos_recursos':
          operacao.gruposDeRecurso.map((grupoDeRecurso) => RemoteGrupoDeRecursoMapper.fromGrupoDeRecursoToMap(grupoDeRecurso)).toList(),
    };
  }
}
