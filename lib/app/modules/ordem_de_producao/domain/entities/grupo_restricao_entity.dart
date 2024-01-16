// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/restricao_entity.dart';

class GrupoDeRestricaoEntity {
  final String id;
  final String codigo;
  final String nome;
  final List<RestricaoEntity> restricoes;

  const GrupoDeRestricaoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.restricoes,
  });

  GrupoDeRestricaoEntity copyWith({
    String? id,
    String? codigo,
    String? nome,
    List<RestricaoEntity>? restricoes,
  }) {
    return GrupoDeRestricaoEntity(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      restricoes: restricoes ?? List.from(this.restricoes),
    );
  }

  @override
  bool operator ==(covariant GrupoDeRestricaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && listEquals(other.restricoes, restricoes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ restricoes.hashCode;
  }
}
