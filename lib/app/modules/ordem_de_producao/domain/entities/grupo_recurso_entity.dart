// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/recurso_entity.dart';

class GrupoDeRecursoEntity {
  final String id;
  final String codigo;
  final String nome;
  final List<RecursoEntity> recursos;

  const GrupoDeRecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.recursos,
  });

  GrupoDeRecursoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    List<RecursoEntity>? recursos,
  }) {
    return GrupoDeRecursoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      recursos: recursos ?? List.from(this.recursos),
    );
  }

  @override
  bool operator ==(covariant GrupoDeRecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.recursos, recursos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ recursos.hashCode;
  }
}
