import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/grupo_restricao_entity.dart';

class RecursoEntity {
  final String id;
  final String codigo;
  final String nome;
  final List<GrupoDeRestricaoEntity> grupoDeRestricoes;

  const RecursoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.grupoDeRestricoes,
  });

  RecursoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    List<GrupoDeRestricaoEntity>? grupoDeRestricoes,
  }) {
    return RecursoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      grupoDeRestricoes: grupoDeRestricoes ?? this.grupoDeRestricoes,
    );
  }

  @override
  bool operator ==(covariant RecursoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.grupoDeRestricoes, grupoDeRestricoes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ grupoDeRestricoes.hashCode;
  }
}
