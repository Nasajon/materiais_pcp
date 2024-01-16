import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_restricao_enum.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_grupo_de_restricao_entity.dart';

class RestricaoGrupoDeRestricaoMapper {
  const RestricaoGrupoDeRestricaoMapper._();

  static RestricaoGrupoDeRestricaoEntity fromMapToGrupoDeRestricaoEntity(Map<String, dynamic> map) {
    return RestricaoGrupoDeRestricaoEntity(
      id: map['grupo_de_restricao'],
      codigo: map['codigo'],
      nome: map['nome'],
      tipo: TipoDeRestricaoEnum.selectTipoRestricao(map['tipo']),
    );
  }
}
