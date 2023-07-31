import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/domain/usecases/delete_grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/deletar_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/recursos/grupo_de_recurso/presenter/stores/states/grupo_de_recurso_state.dart';

import '../../domain/usecases/get_grupo_de_recurso_list_usecase.dart';

class GrupoDeRecursoListStore extends NasajonNotifierStore<List<GrupoDeRecursoState>> {
  final GetGrupoDeRecursoListUsecase _getGrupoDeRecursoListUsecase;
  final DeleteGrupoDeRecursoUsecase _deleteGrupoDeRecursoUsecase;

  GrupoDeRecursoListStore(this._getGrupoDeRecursoListUsecase, this._deleteGrupoDeRecursoUsecase) : super(initialState: []);

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<GrupoDeRecursoState> _listGrupoDeRecurso = [];

  @override
  void initStore() {
    super.initStore();
    getList(delay: Duration.zero);
  }

  void getList({String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(
      delay: delay,
      () async {
        final response = await _getGrupoDeRecursoListUsecase(search);
        _listGrupoDeRecurso
          ..clear()
          ..addAll(
            response
                .map(
                  (grupo) => GrupoDeRecursoState(
                    grupoDeRecurso: grupo,
                    deletarStore: DeletarGrupoDeRecursoStore(
                      _deleteGrupoDeRecursoUsecase,
                    ),
                  ),
                )
                .toList(),
          );

        return _listGrupoDeRecurso;
      },
    );
  }

  Future<void> deleteGrupoDeRecurso(String id) async {
    _listGrupoDeRecurso.removeWhere((element) => element.grupoDeRecurso.id == id);

    update(_listGrupoDeRecurso, force: true);
  }
}
