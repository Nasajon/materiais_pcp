import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/atualizar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_centro_trabalho_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_turno_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/inserir_centro_trabalho_usecase.dart';

class InserirEditarCentroTrabalhoStore extends NasajonStreamStore<CentroTrabalhoAggregate?> {
  final InserirCentroTrabalhoUsecase _inserirCentroTrabalhoUsecase;
  final AtualizarCentroTrabalhoUsecase _atualizarCentroTrabalhoUsecase;
  final GetCentroTrabalhoPorIdUsecase _getCentroTrabalhoPorIdUsecase;
  final GetTurnoCentroTrabalhoUsecase _getTurnoCentroTrabalhoUsecase;

  InserirEditarCentroTrabalhoStore(
    this._inserirCentroTrabalhoUsecase,
    this._atualizarCentroTrabalhoUsecase,
    this._getCentroTrabalhoPorIdUsecase,
    this._getTurnoCentroTrabalhoUsecase,
  ) : super(initialState: null);

  Future<void> adicionarCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    setLoading(true, force: true);

    try {
      final response = await _inserirCentroTrabalhoUsecase(centroTrabalho);

      update(response, force: true);
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

  Future<void> editarCentroTrabalho(CentroTrabalhoAggregate centroTrabalho) async {
    setLoading(true, force: true);

    try {
      final response = await _atualizarCentroTrabalhoUsecase(centroTrabalho);

      if (response) {
        update(centroTrabalho, force: true);
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

  Future<CentroTrabalhoAggregate?> buscarCentroTrabalho(String id) async {
    try {
      final response = await _getCentroTrabalhoPorIdUsecase(id);
      final turnos = await _getTurnoCentroTrabalhoUsecase(id, response.turnos.map((e) => e.id).toList());

      return response.copyWith(turnos: turnos);
    } on Failure catch (e) {
      return null;
    }
  }
}
