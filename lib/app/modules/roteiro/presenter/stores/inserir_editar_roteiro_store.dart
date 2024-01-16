import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/editar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_roteiro_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/inserir_roteiro_usecase.dart';

class InserirEditarRoteiroStore extends NasajonNotifierStore<RoteiroAggregate> {
  final InserirRoteiroUsecase _inserirRoteiroUsecase;
  final EditarRoteiroUsecase _editarRoteiroUsecase;
  final GetRoteiroPorIdUsecase _getRoteiroPorIdUsecase;

  InserirEditarRoteiroStore(
    this._inserirRoteiroUsecase,
    this._editarRoteiroUsecase,
    this._getRoteiroPorIdUsecase,
  ) : super(initialState: RoteiroAggregate.empty());

  Future<RoteiroAggregate?> getRoteiroPorId(String roteiroId) async {
    try {
      final roteiro = await _getRoteiroPorIdUsecase(roteiroId);
      return roteiro;
    } on Failure catch (_) {
      return null;
    }
  }

  Future<void> inserirRoteiro(RoteiroAggregate roteiro) async {
    setLoading(true);

    try {
      final response = await _inserirRoteiroUsecase(roteiro);

      update(roteiro.copyWith(id: response));
    } on RoteiroFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> editarRoteiro(RoteiroAggregate roteiro) async {
    setLoading(true);

    try {
      await _editarRoteiroUsecase(roteiro);

      update(roteiro, force: true);
    } on RoteiroFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
