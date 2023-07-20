import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
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

      update(turnoTrabalho, force: true);
    } on Failure catch (e) {
      await Asuka.showDialog(
        barrierColor: Colors.black38,
        builder: (context) {
          return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
        },
      );

      setError(e, force: true);
    }

    setLoading(false, force: true);
  }

  Future<void> editarTurnoTrabalho(TurnoTrabalhoAggregate turnoTrabalho) async {
    setLoading(true, force: true);

    try {
      final response = await _editarTurnoTrabalhoUsecase(turnoTrabalho);

      if (response) {
        update(turnoTrabalho, force: true);
      }
    } on Failure catch (e) {
      await Asuka.showDialog(
        barrierColor: Colors.black38,
        builder: (context) {
          return ErrorModal(errorMessage: (triple.error as Failure).errorMessage ?? '');
        },
      );

      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
