import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';

class GrupoDeRestricaoEntity {
  final String? id;
  final CodigoVO? codigo;
  final TextVO descricao;
  final TipoDeRestricaoEnum tipo;

  const GrupoDeRestricaoEntity({
    this.id,
    this.codigo,
    required this.descricao,
    required this.tipo,
  });

  factory GrupoDeRestricaoEntity.empty() {
    return GrupoDeRestricaoEntity(
      descricao: TextVO(''),
      tipo: TipoDeRestricaoEnum.componentes,
    );
  }

  GrupoDeRestricaoEntity copyWith({
    String? id,
    CodigoVO? codigo,
    TextVO? descricao,
    TipoDeRestricaoEnum? tipo,
  }) {
    return GrupoDeRestricaoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.descricao == descricao && other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ tipo.hashCode;
  }
}
