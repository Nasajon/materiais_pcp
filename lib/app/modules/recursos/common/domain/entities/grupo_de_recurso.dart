import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

class GrupoDeRecurso {
  final String? id;
  final String codigo;
  final String descricao;
  final TipoDeRecursoEnum? tipo;

  const GrupoDeRecurso({
    this.id,
    required this.codigo,
    required this.descricao,
    this.tipo,
  });

  factory GrupoDeRecurso.empty() {
    return const GrupoDeRecurso(codigo: '', descricao: '');
  }

  GrupoDeRecurso copyWith({
    String? id,
    String? codigo,
    String? descricao,
    TipoDeRecursoEnum? tipo,
  }) {
    return GrupoDeRecurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
    );
  }
}
