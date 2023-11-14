// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/deletar_grupo_de_recurso_store.dart';

class GrupoDeRecursoState {
  final GrupoDeRecurso grupoDeRecurso;
  final DeletarGrupoDeRecursoStore deletarStore;

  GrupoDeRecursoState({
    required this.grupoDeRecurso,
    required this.deletarStore,
  });

  GrupoDeRecursoState copyWith({
    GrupoDeRecurso? grupoDeRecurso,
    DeletarGrupoDeRecursoStore? deletarStore,
  }) {
    return GrupoDeRecursoState(
      grupoDeRecurso: grupoDeRecurso ?? this.grupoDeRecurso,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
