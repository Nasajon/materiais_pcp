// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/aggregates/turno_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/deletar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turno_trabalho_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/domain/usecases/get_turnos_trabalhos_usecase.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/deletar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/turno_de_trabalho/presenter/stores/states/turno_trabalho_state.dart';

class TurnoTrabalhoListStore extends NasajonStreamStore<List<TurnoTrabalhoState>> {
  final GetTurnoTrabalhoRecenteUsecase _getTurnoTrabalhoRecenteUsecase;
  final GetTurnosTrabalhosUsecase _getTurnosTrabalhosUsecase;
  final DeletarTurnoTrabalhoUsecase _deletarTurnoTrabalhoUsecase;

  TurnoTrabalhoListStore(
    this._getTurnoTrabalhoRecenteUsecase,
    this._getTurnosTrabalhosUsecase,
    this._deletarTurnoTrabalhoUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListTurnoTrabalho(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<TurnoTrabalhoState> _listTurnoTrabalho = [];

  Future<void> getListTurnoTrabalho({Duration delay = const Duration(milliseconds: 500)}) async {
    try {
      execute(() async {
        setLoading(true);

        if (search.isEmpty) {
          final response = await _getTurnoTrabalhoRecenteUsecase();
          _listTurnoTrabalho
            ..clear()
            ..addAll(response
                .map(
                  (turnoTrabalho) => TurnoTrabalhoState(
                    turnoTrabalho: turnoTrabalho,
                    deletarStore: DeletarTurnoTrabalhoStore(_deletarTurnoTrabalhoUsecase),
                  ),
                )
                .toList());
          return _listTurnoTrabalho;
        }

        final response = await _getTurnosTrabalhosUsecase(search: search);
        _listTurnoTrabalho
          ..clear()
          ..addAll(response
              .map(
                (turnoTrabalho) => TurnoTrabalhoState(
                  turnoTrabalho: turnoTrabalho,
                  deletarStore: DeletarTurnoTrabalhoStore(_deletarTurnoTrabalhoUsecase),
                ),
              )
              .toList());
        return _listTurnoTrabalho;
      }, delay: delay);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<void> addTurnoTrabalho(TurnoTrabalhoAggregate turnoTrabalho) async {
    _listTurnoTrabalho.add(
      TurnoTrabalhoState(
        turnoTrabalho: turnoTrabalho,
        deletarStore: DeletarTurnoTrabalhoStore(_deletarTurnoTrabalhoUsecase),
      ),
    );

    update(_listTurnoTrabalho, force: true);
  }

  Future<void> updateTurnoTrabalho(TurnoTrabalhoAggregate turnoTrabalho) async {
    for (var i = 0; i < _listTurnoTrabalho.length; i++) {
      if (_listTurnoTrabalho[i].turnoTrabalho.id == turnoTrabalho.id) {
        _listTurnoTrabalho.setAll(i, [
          TurnoTrabalhoState(
            turnoTrabalho: turnoTrabalho,
            deletarStore: DeletarTurnoTrabalhoStore(_deletarTurnoTrabalhoUsecase),
          )
        ]);
        break;
      }
    }

    update(_listTurnoTrabalho, force: true);
  }

  Future<void> deleteTurnoTrabalho(String id) async {
    _listTurnoTrabalho.removeWhere((element) => element.turnoTrabalho.id == id);

    update(_listTurnoTrabalho, force: true);
  }
}
