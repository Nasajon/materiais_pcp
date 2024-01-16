// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'package:pcp_flutter/app/modules/recursos/domain/usecases/delete_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/usecases/get_recurso_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/deletar_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/presenter/stores/states/recurso_state.dart';

import '../../domain/usecases/get_recurso_usecase_list.dart';

class RecursoListStore extends NasajonNotifierStore<List<RecursoState>> {
  final GetRecursoListUsecase _getRecursoListUsecase;
  final GetRecursoRecenteUsecase _getRecursoRecenteUsecase;
  final DeleteRecursoUsecase _deleteRecursoUsecase;

  RecursoListStore(
    this._getRecursoListUsecase,
    this._getRecursoRecenteUsecase,
    this._deleteRecursoUsecase,
  ) : super(initialState: []);

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<RecursoState> _listRecurso = [];

  @override
  void initStore() {
    super.initStore();

    getList(delay: Duration.zero);
  }

  void getList({String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      if (search == null || search.isEmpty) {
        final response = await _getRecursoRecenteUsecase();

        _listRecurso
          ..clear()
          ..addAll(
            response
                .map(
                  (grupo) => RecursoState(
                    recurso: grupo,
                    deletarStore: DeletarRecursoStore(
                      _deleteRecursoUsecase,
                    ),
                  ),
                )
                .toList(),
          );

        return _listRecurso;
      }

      final response = await _getRecursoListUsecase(search);

      _listRecurso
        ..clear()
        ..addAll(
          response
              .map(
                (grupo) => RecursoState(
                  recurso: grupo,
                  deletarStore: DeletarRecursoStore(
                    _deleteRecursoUsecase,
                  ),
                ),
              )
              .toList(),
        );

      return _listRecurso;
    }, delay: delay);
  }

  Future<void> deleteRecurso(String id) async {
    _listRecurso.removeWhere((element) => element.recurso.id == id);

    update(_listRecurso, force: true);
  }
}
