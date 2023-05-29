import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';

class GrupoDeRestricaoMapper {
  const GrupoDeRestricaoMapper._();

  static GrupoDeRestricaoEntity fromMapToGrupoDeRestricaoEntity(Map<String, dynamic> map) {
    return GrupoDeRestricaoEntity(
      id: map['grupo_de_restricao'],
      codigo: map['codigo'],
      descricao: map['descricao'],
      tipo: TipoDeRestricaoEnum.selectTipoRestricao(map['tipo']),
    );
  }

  static Map<String, dynamic> fromGrupoDeRestricaoEntityToMap(GrupoDeRestricaoEntity grupoDeRestricao) {
    return {
      'grupo_de_restricao': grupoDeRestricao.id,
      'codigo': grupoDeRestricao.codigo,
      'descricao': grupoDeRestricao.descricao,
      'tipo': grupoDeRestricao.tipo.value,
    };
  }
}
