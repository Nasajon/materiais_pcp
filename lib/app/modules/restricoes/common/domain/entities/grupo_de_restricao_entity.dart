import 'package:pcp_flutter/app/modules/restricoes/common/domain/enum/tipo_de_restricao_enum.dart';

class GrupoDeRestricaoEntity {
  final String? id;
  final String? codigo;
  final String descricao;
  final TipoDeRestricaoEnum tipo;

  const GrupoDeRestricaoEntity({
    this.id,
    this.codigo,
    required this.descricao,
    required this.tipo,
  });

  factory GrupoDeRestricaoEntity.empty() {
    return const GrupoDeRestricaoEntity(
      descricao: '',
      tipo: TipoDeRestricaoEnum.componentes,
    );
  }

  GrupoDeRestricaoEntity copyWith({
    String? id,
    String? codigo,
    String? descricao,
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
