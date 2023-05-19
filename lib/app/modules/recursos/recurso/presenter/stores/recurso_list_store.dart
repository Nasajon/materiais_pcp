import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';

import '../../domain/entities/recurso.dart';
import '../../domain/usecases/get_recurso_usecase_list.dart';

class RecursoListStore extends NasajonNotifierStore<List<Recurso>> {
  final GetRecursoListUsecase _getRecursoListUsecase;

  RecursoListStore(this._getRecursoListUsecase) : super(initialState: []);

  final pesquisaController = TextEditingController();

  @override
  void initStore() {
    super.initStore();

    getList(delay: Duration.zero);
  }

  void getList(
      {String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() => _getRecursoListUsecase(search), delay: delay);
  }
}
