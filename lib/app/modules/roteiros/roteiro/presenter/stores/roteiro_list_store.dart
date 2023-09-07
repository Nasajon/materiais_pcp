import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/aggregates/roteiro_aggregate.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/deletar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/deletar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/states/roteiro_state.dart';

class RoteiroListStore extends NasajonNotifierStore<List<RoteiroState>> {
  final GetRoteiroUsecase _getRoteiroUsecase;
  final GetRoteiroRecenteUsecase _getRoteiroRecenteUsecase;
  final DeletarRoteiroUsecase _deletarRoteiroUsecase;

  RoteiroListStore(
    this._getRoteiroUsecase,
    this._getRoteiroRecenteUsecase,
    this._deletarRoteiroUsecase,
  ) : super(initialState: []);

  String search = '';

  Future<void> getRoteiros({String search = '', Duration delay = const Duration(milliseconds: 500)}) async {
    this.search = search;

    try {
      execute(
        delay: delay,
        () async {
          if (search.isEmpty) {
            final listRoteiro = await _getRoteiroRecenteUsecase();
            final roteiroState = listRoteiro
                .map(
                  (roteiro) => RoteiroState(
                    roteiro: roteiro,
                    deletarRoteiroStore: DeletarRoteiroStore(_deletarRoteiroUsecase),
                  ),
                )
                .toList();

            return roteiroState;
          }

          setLoading(true);
          final listRoteiro = await _getRoteiroUsecase(search);
          final roteiroState = listRoteiro
              .map(
                (roteiro) => RoteiroState(
                  roteiro: roteiro,
                  deletarRoteiroStore: DeletarRoteiroStore(_deletarRoteiroUsecase),
                ),
              )
              .toList();
          return roteiroState;
        },
      );
    } on RoteiroFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }

  void adicionarRoteiro(RoteiroAggregate roteiro) {
    state.add(
      RoteiroState(
        roteiro: RoteiroEntity(id: roteiro.id, codigo: roteiro.codigo.toText, descricao: roteiro.descricao.value, produto: roteiro.produto),
        deletarRoteiroStore: DeletarRoteiroStore(_deletarRoteiroUsecase),
      ),
    );

    update(state, force: true);
  }

  Future<void> deletarRoteiro(String id) async {
    state.removeWhere((roteiro) => roteiro.roteiro.id == id);

    update(state, force: true);
  }
}
