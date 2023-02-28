import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import '../../../grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

class Recurso {
  final String? id;
  final String codigo;
  final String descricao;
  final TipoDeRecurso? tipo;
  final GrupoDeRecurso? grupoDeRecurso;
  final double? custoHora;

  Recurso({
    this.id,
    required this.codigo,
    required this.descricao,
    required this.tipo,
    this.grupoDeRecurso,
    this.custoHora,
  });

  @override
  bool operator ==(covariant Recurso other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.tipo == tipo &&
        other.grupoDeRecurso == grupoDeRecurso &&
        other.custoHora == custoHora;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        descricao.hashCode ^
        tipo.hashCode ^
        grupoDeRecurso.hashCode ^
        custoHora.hashCode;
  }
}
