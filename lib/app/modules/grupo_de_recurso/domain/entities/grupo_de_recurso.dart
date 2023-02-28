import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';

class GrupoDeRecurso {
  final String? id;
  final String codigo;
  final String descricao;
  final TipoDeRecurso? tipo;

  GrupoDeRecurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.tipo,
  });

  @override
  bool operator ==(covariant GrupoDeRecurso other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ tipo.hashCode;
  }
}
