import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';

class GrupoDeRestricaoController {
  final _grupoDeRestricaoNotifier = RxNotifier(GrupoDeRestricaoEntity.empty());
  GrupoDeRestricaoEntity get grupoDeRestricao => _grupoDeRestricaoNotifier.value;
  set grupoDeRestricao(GrupoDeRestricaoEntity grupoDeRestricao) => _grupoDeRestricaoNotifier.value = grupoDeRestricao;

  final _isEnabledNotifier = RxNotifier(true);
  bool get isEnabled => _isEnabledNotifier.value;
  set isEnabled(bool value) => _isEnabledNotifier.value = value;

  final _isLoadingNotifier = RxNotifier(false);
  bool get isLoading => _isLoadingNotifier.value;
  set isLoading(bool value) => _isLoadingNotifier.value = value;

  void grupoDeRestricaoNotifyListeners() {
    grupoDeRestricao = grupoDeRestricao.copyWith();
  }
}
