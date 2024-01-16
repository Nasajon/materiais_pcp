// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/core/modules/domain/enums/tipo_de_restricao_enum.dart';

class RestricaoGrupoDeRestricaoEntity {
  final String id;
  final String codigo;
  final String nome;
  final TipoDeRestricaoEnum? tipo;

  const RestricaoGrupoDeRestricaoEntity({
    required this.id,
    required this.codigo,
    required this.nome,
    this.tipo,
  });

  factory RestricaoGrupoDeRestricaoEntity.empty() {
    return const RestricaoGrupoDeRestricaoEntity(
      id: '',
      codigo: '',
      nome: '',
    );
  }

  @override
  bool operator ==(covariant RestricaoGrupoDeRestricaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.codigo == codigo && other.nome == nome && other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ nome.hashCode ^ tipo.hashCode;
  }
}
