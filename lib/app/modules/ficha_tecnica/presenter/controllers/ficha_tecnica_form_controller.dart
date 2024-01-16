import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_produto_aggregate.dart';

class FichaTecnicaFormController {
  final _fichaTecnicaNotifier = RxNotifier(FichaTecnicaAggregate.empty());
  FichaTecnicaAggregate get fichaTecnica => _fichaTecnicaNotifier.value;
  set fichaTecnica(FichaTecnicaAggregate value) => _fichaTecnicaNotifier.value = value;

  final _fichaTecnicaOldNotifier = RxNotifier<FichaTecnicaAggregate?>(null);
  FichaTecnicaAggregate? get fichaTecnicaOld => _fichaTecnicaOldNotifier.value;
  set fichaTecnicaOld(FichaTecnicaAggregate? value) => _fichaTecnicaOldNotifier.value = value;

  final _fichaTecnicaProduto = RxNotifier<FichaTecnicaMaterialAggregate?>(null);
  set material(FichaTecnicaMaterialAggregate? value) => _fichaTecnicaProduto.value = value;
  FichaTecnicaMaterialAggregate? get material => _fichaTecnicaProduto.value;

  final _isLoadingNotifier = RxNotifier(false);
  bool get isLoading => _isLoadingNotifier.value;
  set isLoading(bool value) => _isLoadingNotifier.value = value;

  final _isEnabledNotifier = RxNotifier(true);
  bool get isEnabled => _isEnabledNotifier.value;
  set isEnabled(bool value) => _isEnabledNotifier.value = value;

  void fichaTecnicaNotifyListeners() {
    fichaTecnica = fichaTecnica.copyWith();
  }

  initOld() {
    fichaTecnicaOld ??= fichaTecnica.copyWith();
  }

  updateOld() {
    fichaTecnicaOld = fichaTecnica.copyWith();
  }

  resetOld() {
    fichaTecnicaOld = null;
  }

  void removerMaterial(int index) {
    fichaTecnica.materiais.removeAt(index - 1);

    for (var i = 0; i < fichaTecnica.materiais.length; i++) {
      fichaTecnica.materiais[i] = fichaTecnica.materiais[i].copyWith(codigo: i + 1);
    }

    fichaTecnica = fichaTecnica.copyWith();
  }

  void criarEditarMaterial(FichaTecnicaMaterialAggregate material) {
    if (material.codigo == 0) {
      fichaTecnica.materiais.add(
        material,
      );
    } else {
      fichaTecnica.materiais[material.codigo - 1] = material;
    }

    for (var i = 0; i < fichaTecnica.materiais.length; i++) {
      fichaTecnica.materiais[i] = fichaTecnica.materiais[i].copyWith(codigo: i + 1);
    }

    this.material = null;
    fichaTecnica = fichaTecnica.copyWith();
  }
}
