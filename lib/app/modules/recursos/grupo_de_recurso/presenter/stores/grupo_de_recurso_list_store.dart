import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

import '../../domain/usecases/get_grupo_de_recurso_list_usecase.dart';

class GrupoDeRecursoListStore extends NasajonNotifierStore<List<GrupoDeRecurso>> {
  final GetGrupoDeRecursoListUsecase _getGrupoDeRecursoListUsecase;

  GrupoDeRecursoListStore(this._getGrupoDeRecursoListUsecase) : super(initialState: []);

  final pesquisaController = TextEditingController();

  @override
  void initStore() {
    super.initStore();
    getList(delay: Duration.zero);
  }

  void getList({String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() => _getGrupoDeRecursoListUsecase(search), delay: delay);
  }
}
