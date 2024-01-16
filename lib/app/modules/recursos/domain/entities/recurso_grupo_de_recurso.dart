// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_recurso_enum.dart';

class RecursoGrupoDeRecurso {
  final String id;
  final String codigo;
  final String nome;
  final TipoDeRecursoEnum? tipo;

  const RecursoGrupoDeRecurso({
    required this.id,
    required this.codigo,
    required this.nome,
    this.tipo,
  });

  factory RecursoGrupoDeRecurso.empty() {
    return const RecursoGrupoDeRecurso(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  RecursoGrupoDeRecurso copyWith({
    String? id,
    String? codigo,
    String? nome,
    TipoDeRecursoEnum? tipo,
  }) {
    return RecursoGrupoDeRecurso(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  bool operator ==(covariant RecursoGrupoDeRecurso other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ tipo.hashCode;
  }
}
