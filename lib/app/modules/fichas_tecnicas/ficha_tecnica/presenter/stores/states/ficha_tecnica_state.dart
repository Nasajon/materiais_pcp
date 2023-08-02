// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/presenter/stores/deletar_ficha_tecnica_store.dart';

class FichaTecnicaState {
  final FichaTecnicaAggregate fichaTecnica;
  final DeletarFichaTecnicaStore deletarStore;

  FichaTecnicaState({
    required this.fichaTecnica,
    required this.deletarStore,
  });

  FichaTecnicaState copyWith({
    FichaTecnicaAggregate? fichaTecnica,
    DeletarFichaTecnicaStore? deletarStore,
  }) {
    return FichaTecnicaState(
      fichaTecnica: fichaTecnica ?? this.fichaTecnica,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
