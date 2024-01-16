// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/recursos/domain/entities/recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/deletar_recurso_store.dart';

class RecursoState {
  final Recurso recurso;
  final DeletarRecursoStore deletarStore;

  RecursoState({
    required this.recurso,
    required this.deletarStore,
  });

  RecursoState copyWith({
    Recurso? recurso,
    DeletarRecursoStore? deletarStore,
  }) {
    return RecursoState(
      recurso: recurso ?? this.recurso,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
