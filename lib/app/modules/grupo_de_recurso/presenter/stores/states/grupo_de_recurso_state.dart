import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/presenter/stores/deletar_grupo_de_recurso_store.dart';

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
