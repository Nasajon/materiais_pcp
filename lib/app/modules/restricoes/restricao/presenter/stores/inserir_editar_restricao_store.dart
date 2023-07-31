import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/insert_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/update_restricao_usecase.dart';

class InserirEditarRestricaoStore extends NasajonStreamStore<RestricaoAggregate?> {
  final InsertRestricaoUsecase _inserirRestricaoUsecase;
  final UpdateRestricaoUsecase _editarRestricaoUsecase;

  InserirEditarRestricaoStore(
    this._inserirRestricaoUsecase,
    this._editarRestricaoUsecase,
  ) : super(initialState: null);

  Future<void> adicionarRestricao(RestricaoAggregate restricao) async {
    setLoading(true, force: true);

    try {
      final response = await _inserirRestricaoUsecase(restricao);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }

  Future<void> editarRestricao(RestricaoAggregate restricao) async {
    setLoading(true, force: true);

    try {
      final response = await _editarRestricaoUsecase(restricao);

      if (response) {
        update(restricao, force: true);
      }
    } on Failure catch (error) {
      setError(error, force: true);
    }

    setLoading(false, force: true);
  }
}
