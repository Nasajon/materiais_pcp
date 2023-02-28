import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../domain/entities/recurso.dart';
import '../../domain/usecases/get_recurso_usecase_list.dart';

class RecursoListStore extends StreamStore<Failure, List<Recurso>> {
  final GetRecursoListUsecase _getRecursoListUsecase;

  RecursoListStore(this._getRecursoListUsecase) : super([]);

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
