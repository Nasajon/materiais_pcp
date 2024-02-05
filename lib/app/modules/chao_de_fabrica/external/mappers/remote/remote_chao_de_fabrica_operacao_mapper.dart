import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/entities/chao_de_fabrica_operacao_entity.dart';

class RemoteChaoDeFabricaOperacaoMapper {
  const RemoteChaoDeFabricaOperacaoMapper._();

  static ChaoDeFabricaOperacaoEntity fromMapToOperacaoEntity(Map<String, dynamic> map) {
    return ChaoDeFabricaOperacaoEntity(
      id: map['operacao'],
      OperacaoOrdemId: map['operacao_ordem'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
