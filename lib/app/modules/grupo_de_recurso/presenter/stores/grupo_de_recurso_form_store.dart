import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import '../../domain/entities/grupo_de_recurso.dart';
import '../../domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import '../../domain/usecases/save_grupo_de_recurso_usecase.dart';
import 'states/grupo_de_recurso_form_state.dart';

class GrupoDeRecursoFormStore
    extends StreamStore<Failure, GrupoDeRecursoFormState> {
  final GetGrupoDeRecursoByIdUsecase _getGrupoDeRecursoByIdUsecase;
  final SaveGrupoDeRecursoUsecase _saveGrupoDeRecursoUsecase;

  GrupoDeRecursoFormStore(
    this._getGrupoDeRecursoByIdUsecase,
    this._saveGrupoDeRecursoUsecase,
  ) : super(GrupoDeRecursoFormState.empty());

  final codigoController = TextEditingController();
  final nomeController = TextEditingController();
  final selectedTipoDeRecurso =
      ValueNotifier<DropdownItem<TipoDeRecurso?>?>(null);

  void selectTipoDeRecurso(TipoDeRecurso? tipoDeRecurso) =>
      selectedTipoDeRecurso.value =
          DropdownItem(value: tipoDeRecurso, label: tipoDeRecurso?.name ?? '');

  Future<void> pegarGrupoDeRecurso(String id) async {
    await execute(() async {
      final grupoDeRecurso = await _getGrupoDeRecursoByIdUsecase(id);

      _preencherCampos(grupoDeRecurso);

      return state.copyWith(grupoDeRecurso: () => grupoDeRecurso);
    });
  }

  void _preencherCampos(GrupoDeRecurso grupoDeRecurso) {
    codigoController.value = TextEditingValue(text: grupoDeRecurso.codigo);
    nomeController.value = TextEditingValue(text: grupoDeRecurso.descricao);

    selectTipoDeRecurso(grupoDeRecurso.tipo);
  }

  Future<void> salvar() async {
    try {
      setLoading(true);

      final grupoDeRecurso = GrupoDeRecurso(
        id: state.grupoDeRecurso?.id,
        codigo: codigoController.text,
        descricao: nomeController.text,
        tipo: selectedTipoDeRecurso.value!.value!,
      );

      await _saveGrupoDeRecursoUsecase(grupoDeRecurso);

      clear();
    } on Failure {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void clear() {
    codigoController.clear();
    nomeController.clear();

    selectTipoDeRecurso(null);
    update(state.copyWith(grupoDeRecurso: () => null));
  }
}
