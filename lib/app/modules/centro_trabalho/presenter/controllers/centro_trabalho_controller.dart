import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/aggreagates/centro_trabalho_aggregate.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/entities/turno_trabalho_entity.dart';

class CentroTrabalhoController {
  final _centroTrabalhoNotifier = RxNotifier(CentroTrabalhoAggregate.empty());
  CentroTrabalhoAggregate get centroTrabalho => _centroTrabalhoNotifier.value;
  set centroTrabalho(CentroTrabalhoAggregate value) => _centroTrabalhoNotifier.value = value;

  final _turnoTrabalhoNotifier = RxNotifier<List<TurnoTrabalhoEntity>>([]);
  List<TurnoTrabalhoEntity> get turnosDeTrabalho => _turnoTrabalhoNotifier.value;
  set turnosDeTrabalho(List<TurnoTrabalhoEntity> value) => _turnoTrabalhoNotifier.value = value;

  final _isLoadingNotifier = RxNotifier(false);
  bool get isLoading => _isLoadingNotifier.value;
  set isLoading(bool value) => _isLoadingNotifier.value = value;

  final _isEnabledNotifier = RxNotifier(true);
  bool get isEnabled => _isEnabledNotifier.value;
  set isEnabled(bool value) => _isEnabledNotifier.value = value;

  final getTurnoTrabalhoAction = RxNotifier(RxVoid);

  void centroTrabalhoNotifyListeners() {
    centroTrabalho = centroTrabalho.copyWith();
  }
}
