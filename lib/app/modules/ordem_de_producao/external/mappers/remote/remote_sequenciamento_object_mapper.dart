import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/sequenciamento_objetct_entity.dart';

class RemoteSequenciamentoRecursoERestricaoMapper {
  const RemoteSequenciamentoRecursoERestricaoMapper._();

  static SequenciamentoObjectEntity fromMapToSequenciamentoSequenciamentoObject(Map<String, dynamic> map) {
    return SequenciamentoObjectEntity(
      id: map.containsKey('recurso') ? map['recurso'] : map['restricao'],
      codigo: map['codigo'],
      nome: map['nome'],
    );
  }
}
