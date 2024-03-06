import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_apontamento_entity.dart';

class RemoteChaoDeFabricaApontamentoMapper {
  const RemoteChaoDeFabricaApontamentoMapper._();

  static Map<String, dynamic> fromChaoDeFabricaApontamentoToMap(ChaoDeFabricaApontamentoEntity apontamento) {
    return {
      'atividade_recurso': apontamento.id,
      'quantidade_apontada': apontamento.quantidade.value,
      'percentual': apontamento.progresso.value,
      'unidade': apontamento.unidade.id,
      'produtos': apontamento.materiais.map((material) {
        return {
          'produto_atividade': material.id,
          'atividade_recurso': material.atividadeRecursoId,
          'quantidade_utilizada': material.quantidadeUtilizada.value,
          'quantidade_perda': material.quantidadePerda.value,
          'produto': material.produto.id,
          'unidade': material.unidade.id,
        };
      }).toList(),
    };
  }
}
