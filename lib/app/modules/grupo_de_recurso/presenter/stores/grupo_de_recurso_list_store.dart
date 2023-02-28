import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../domain/entities/grupo_de_recurso.dart';
import '../../domain/usecases/get_grupo_de_recurso_list_usecase.dart';

class GrupoDeRecursoListStore
    extends StreamStore<Failure, List<GrupoDeRecurso>> {
  final GetGrupoDeRecursoListUsecase _getGrupoDeRecursoListUsecase;

  GrupoDeRecursoListStore(this._getGrupoDeRecursoListUsecase) : super([]);

  final pesquisaController = TextEditingController();

  @override
  void initStore() {
    super.initStore();

    getList(delay: Duration.zero);

    // update([
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento()),
    //   GrupoDeRecurso(
    //       codigo: 'codigo',
    //       descricao: 'descricao',
    //       tipo: TipoDeRecurso.equipamento())
    // ]);
  }

  void getList(
      {String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() => _getGrupoDeRecursoListUsecase(search), delay: delay);
  }
}
