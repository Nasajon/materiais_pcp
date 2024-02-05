import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';

class ChaoDeFabricaAtividadeFilterReducer extends RxReducer {
  final ChaoDeFabricaListStore _chaoDeFabricaListStore;
  final ChaoDeFabricaFilterController _chaoDeFabricaFilterController;

  ChaoDeFabricaAtividadeFilterReducer({
    required ChaoDeFabricaListStore chaoDeFabricaListStore,
    required ChaoDeFabricaFilterController chaoDeFabricaFilterController,
  })  : _chaoDeFabricaListStore = chaoDeFabricaListStore,
        _chaoDeFabricaFilterController = chaoDeFabricaFilterController {
    on(() => [_chaoDeFabricaFilterController.atividadeFilter], getAtividades);
  }

  Future<void> getAtividades() async {
    _chaoDeFabricaListStore.getAtividades(_chaoDeFabricaFilterController.atividadeFilter);
  }
}
