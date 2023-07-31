import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/enum/tipo_de_recurso_enum.dart';

import '../../domain/entities/recurso.dart';
import '../../domain/usecases/get_recurso_by_usecase_id.dart';
import '../../domain/usecases/save_recurso_usecase.dart';
import 'states/recurso_form_state.dart';

class RecursoFormStore extends NasajonStreamStore<Recurso?> {
  final GetRecursoByIdUsecase _getRecursoByIdUsecase;
  final SaveRecursoUsecase _saveRecursoUsecase;

  RecursoFormStore(
    this._getRecursoByIdUsecase,
    this._saveRecursoUsecase,
  ) : super(initialState: null);

  final selectedTipoDeRecurso = ValueNotifier<DropdownItem<TipoDeRecursoEnum?>?>(null);

  Future<Recurso> pegarRecurso(String id) async {
    return await _getRecursoByIdUsecase(id);
  }

  Future<void> salvar(Recurso recurso) async {
    try {
      setLoading(true);

      final response = await _saveRecursoUsecase(recurso);

      update(response);
    } on Failure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
