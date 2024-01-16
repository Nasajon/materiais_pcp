// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/deletar_turno_trabalho_store.dart';

class TurnoTrabalhoState {
  final TurnoTrabalhoAggregate turnoTrabalho;
  final DeletarTurnoTrabalhoStore deletarStore;

  TurnoTrabalhoState({
    required this.turnoTrabalho,
    required this.deletarStore,
  });

  TurnoTrabalhoState copyWith({
    TurnoTrabalhoAggregate? turnoTrabalho,
    DeletarTurnoTrabalhoStore? deletarStore,
  }) {
    return TurnoTrabalhoState(
      turnoTrabalho: turnoTrabalho ?? this.turnoTrabalho,
      deletarStore: deletarStore ?? this.deletarStore,
    );
  }
}
