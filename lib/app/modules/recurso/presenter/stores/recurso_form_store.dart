import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../../../core/modules/tipo_de_recurso/domain/entities/tipo_de_recurso.dart';
import '../../../grupo_de_recurso/domain/entities/grupo_de_recurso.dart';
import '../../domain/entities/recurso.dart';
import '../../domain/usecases/get_recurso_by_usecase_id.dart';
import '../../domain/usecases/save_recurso_usecase.dart';
import 'states/recurso_form_state.dart';

class RecursoFormStore extends StreamStore<Failure, RecursoFormState> {
  final GetRecursoByIdUsecase _getRecursoByIdUsecase;
  final SaveRecursoUsecase _saveRecursoUsecase;

  RecursoFormStore(
    this._getRecursoByIdUsecase,
    this._saveRecursoUsecase,
  ) : super(RecursoFormState.empty());

  final codigoController = TextEditingController();
  final nomeController = TextEditingController();
  final custoHoraController = TextEditingController();

  final selectedTipoDeRecurso =
      ValueNotifier<DropdownItem<TipoDeRecurso?>?>(null);

  void selectTipoDeRecurso(TipoDeRecurso? tipoDeRecurso) =>
      selectedTipoDeRecurso.value =
          DropdownItem(value: tipoDeRecurso, label: tipoDeRecurso?.name ?? '');

  final selectedGrupoDeRecurso =
      ValueNotifier<DropdownItem<GrupoDeRecurso?>?>(null);

  void selectGrupoDeRecurso(GrupoDeRecurso? grupoDeRecurso) =>
      selectedGrupoDeRecurso.value = DropdownItem(
          value: grupoDeRecurso, label: grupoDeRecurso?.codigo ?? '');

  pegarRecurso(String id) {
    execute(() async {
      final recurso = await _getRecursoByIdUsecase(id);

      _preencherCampos(recurso);

      return state.copyWith(recurso: () => recurso);
    });
  }

  void _preencherCampos(Recurso recurso) {
    codigoController.value = TextEditingValue(text: recurso.codigo);
    nomeController.value = TextEditingValue(text: recurso.descricao);
    custoHoraController.value = TextEditingValue(
        text: UtilBrasilFields.obterReal(recurso.custoHora ?? 0,
            decimal: 2, moeda: true));

    selectTipoDeRecurso(recurso.tipo);
    selectGrupoDeRecurso(recurso.grupoDeRecurso);
  }

  Future<void> salvar() async {
    try {
      setLoading(true);

      final grupoDeRecurso = Recurso(
        id: state.recurso?.id,
        codigo: codigoController.text,
        descricao: nomeController.text,
        tipo: selectedTipoDeRecurso.value!.value!,
        grupoDeRecurso: selectedGrupoDeRecurso.value!.value,
        custoHora:
            UtilBrasilFields.converterMoedaParaDouble(custoHoraController.text),
      );

      await _saveRecursoUsecase(grupoDeRecurso);

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
    custoHoraController.clear();

    selectTipoDeRecurso(null);
    selectGrupoDeRecurso(null);
    update(state.copyWith(recurso: () => null));
  }
}
