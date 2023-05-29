import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_list_usecase.dart';

class GrupoDeRestricaoListStore extends NasajonNotifierStore<List<GrupoDeRestricaoEntity>> {
  final GetGrupoDeRestricaoListUsecase _getGrupoDeRestricaoListUsecase;

  GrupoDeRestricaoListStore(this._getGrupoDeRestricaoListUsecase) : super(initialState: []);

  final pesquisaController = TextEditingController();

  @override
  void initStore() {
    super.initStore();
    getList(delay: Duration.zero);
  }

  void getList({String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() => _getGrupoDeRestricaoListUsecase(search), delay: delay);
  }
}
