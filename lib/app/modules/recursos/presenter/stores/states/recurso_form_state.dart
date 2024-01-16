import 'package:flutter/cupertino.dart';

import '../../../domain/entities/recurso.dart';

class RecursoFormState {
  final Recurso? recurso;

  RecursoFormState({
    this.recurso,
  });

  factory RecursoFormState.empty() => RecursoFormState();

  RecursoFormState copyWith({
    ValueGetter<Recurso?>? recurso,
  }) {
    return RecursoFormState(
      recurso: recurso != null ? recurso() : this.recurso,
    );
  }
}
