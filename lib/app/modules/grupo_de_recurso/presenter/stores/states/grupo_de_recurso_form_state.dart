import 'package:flutter/cupertino.dart';

import '../../../domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoFormState {
  final GrupoDeRecurso? grupoDeRecurso;

  GrupoDeRecursoFormState({this.grupoDeRecurso});

  factory GrupoDeRecursoFormState.empty() =>
      GrupoDeRecursoFormState(grupoDeRecurso: null);

  GrupoDeRecursoFormState copyWith({
    ValueGetter<GrupoDeRecurso?>? grupoDeRecurso,
  }) {
    return GrupoDeRecursoFormState(
      grupoDeRecurso:
          grupoDeRecurso != null ? grupoDeRecurso() : this.grupoDeRecurso,
    );
  }
}
