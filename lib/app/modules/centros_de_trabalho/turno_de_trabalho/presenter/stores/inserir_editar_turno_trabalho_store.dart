import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/editar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/inserir_turno_trabalho_usecase.dart';

class InserirEditarTurnoTrabalhoStore extends NasajonStreamStore<TurnoTrabalhoAggregate?> {
  final InserirTurnoTrabalhoUsecase _inserirTurnoTrabalhoUsecase;
  final EditarTurnoTrabalhoUsecase _editarTurnoTrabalhoUsecase;

  InserirEditarTurnoTrabalhoStore(
    this._inserirTurnoTrabalhoUsecase,
    this._editarTurnoTrabalhoUsecase,
  ) : super(initialState: null);

  Future<void> adicionarTurnoTrabalho(TurnoTrabalhoAggregate turnoTrabalho) async {
    setLoading(true, force: true);

    try {
      final response = await _inserirTurnoTrabalhoUsecase(turnoTrabalho);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false);
  }

  Future<void> editarTurnoTrabalho(TurnoTrabalhoAggregate turnoTrabalho) async {
    setLoading(true, force: true);

    try {
      final response = await _editarTurnoTrabalhoUsecase(turnoTrabalho);

      if (response) {
        update(turnoTrabalho, force: true);
      }
    } on Failure catch (error) {
      setError(error, force: true);
    }

    setLoading(false, force: true);
  }
}
