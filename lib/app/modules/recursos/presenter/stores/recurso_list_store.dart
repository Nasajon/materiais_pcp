// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/domain/errors/recurso_failures.dart';

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

  @override
  void initStore() {
    super.initStore();

    getList();
  }

  void getList({String? search}) async {
    setLoading(true);

    try {
      if (search == null || search.isEmpty) {
        final response = await _getRecursoRecenteUsecase();

        final listRecurso = response
            .map(
              (grupo) => RecursoState(
                recurso: grupo,
                deletarStore: DeletarRecursoStore(
                  _deleteRecursoUsecase,
                ),
              ),
            )
            .toList();

        update(listRecurso, force: true);
      } else {
        final response = await _getRecursoListUsecase(search);

        final listRecurso = response
            .map(
              (grupo) => RecursoState(
                recurso: grupo,
                deletarStore: DeletarRecursoStore(
                  _deleteRecursoUsecase,
                ),
              ),
            )
            .toList();

        update(listRecurso, force: true);
      }
    } on RecursoFailure catch (error) {
      NhidsOverlay.error(message: error.errorMessage ?? '');
      setError(error);
    } finally {
      setLoading(false, force: true);
    }
  }

  Future<void> deleteRecurso(String id) async {
    final listRecurso = state;

    listRecurso.removeWhere((element) => element.recurso.id == id);

    update(listRecurso, force: true);
  }
}
