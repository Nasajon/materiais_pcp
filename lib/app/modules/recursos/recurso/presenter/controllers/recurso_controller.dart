import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';

class RecursoController {
  final _recursoNotifier = RxNotifier(Recurso.empty());
  Recurso get recurso => _recursoNotifier.value;
  set recurso(Recurso recurso) => _recursoNotifier.value = recurso;

  void recursoNotifyListeners() => _recursoNotifier.call();

  final _isEnabledNotifier = RxNotifier(true);
  bool get isEnabled => _isEnabledNotifier.value;
  set isEnabled(bool value) => _isEnabledNotifier.value = value;

  final _isLoadingNotifier = RxNotifier(false);
  bool get isLoading => _isLoadingNotifier.value;
  set isLoading(bool value) => _isLoadingNotifier.value = value;
}
