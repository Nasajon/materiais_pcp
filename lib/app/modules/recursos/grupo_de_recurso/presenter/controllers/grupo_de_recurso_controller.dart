import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoController {
  final _grupoDeRecursoNotifier = RxNotifier(GrupoDeRecurso.empty());
  GrupoDeRecurso get grupoDeRecurso => _grupoDeRecursoNotifier.value;
  set grupoDeRecurso(GrupoDeRecurso grupoDeRecurso) => _grupoDeRecursoNotifier.value = grupoDeRecurso;

  void grupoDeRecursoNotifyListeners() => _grupoDeRecursoNotifier.call();

  final _isEnabledNotifier = RxNotifier(true);
  bool get isEnabled => _isEnabledNotifier.value;
  set isEnabled(bool value) => _isEnabledNotifier.value = value;

  final _isLoadingNotifier = RxNotifier(false);
  bool get isLoading => _isLoadingNotifier.value;
  set isLoading(bool value) => _isLoadingNotifier.value = value;
}
