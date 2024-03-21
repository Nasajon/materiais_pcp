import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_finalizar_entity.dart';

class RemoteChaoDeFabricaFinalizarMapper {
  const RemoteChaoDeFabricaFinalizarMapper._();

  static Map<String, dynamic> fromChaoDeFabricaFinalizarToMap(ChaoDeFabricaFinalizarEntity finalizar) {
    return {
      'atividade_recurso': finalizar.id,
      'quantidade_produzida': finalizar.quantidade.value,
      'fim': '${finalizar.data.dateFormat(format: 'yyyy-MM-dd')}T${finalizar.horario.timeFormat(shouldAddSeconds: true)}',
      'unidade': finalizar.unidade.id,
      'produtos': finalizar.materiais.map((material) {
        return {
          'produto_atividade': material.id,
          'atividade_recurso': material.atividadeRecursoId,
          'quantidade_utilizada': material.quantidadeUtilizada.value,
          'quantidade_perda': material.quantidadePerda.value,
          'quantidade_sobra': material.quantidadeSobra.value,
          'produto': material.produto.id,
          'unidade': material.unidade.id,
        };
      }).toList(),
    };
  }
}
