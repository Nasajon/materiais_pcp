// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/deletar_grupo_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_list_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/deletar_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/grupo_de_restricao/presenter/stores/states/grupo_de_restricao_state.dart';

class GrupoDeRestricaoListStore extends NasajonNotifierStore<List<GrupoDeRestricaoState>> {
  final GetGrupoDeRestricaoListUsecase _getGrupoDeRestricaoListUsecase;
  final GetGrupoDeRestricaoRecenteUsecase _getGrupoDeRestricaoRecenteUsecase;
  final DeletarGrupoDeRestricaoUsecase _deletarGrupoDeRestricaoUsecase;

  GrupoDeRestricaoListStore(
    this._getGrupoDeRestricaoListUsecase,
    this._getGrupoDeRestricaoRecenteUsecase,
    this._deletarGrupoDeRestricaoUsecase,
  ) : super(initialState: []);

  final pesquisaController = TextEditingController();

  final _listGrupoDeRestricao = <GrupoDeRestricaoState>[];

  @override
  void initStore() {
    super.initStore();
    getList(delay: Duration.zero);
  }

  void getList({String? search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      if (search == null || search.isEmpty) {
        final response = await _getGrupoDeRestricaoRecenteUsecase();
        _listGrupoDeRestricao
          ..clear()
          ..addAll(
            response.map(
              (e) => GrupoDeRestricaoState(
                grupoDeRestricao: e,
                deletarStore: DeletarGrupoDeRestricaoStore(_deletarGrupoDeRestricaoUsecase),
              ),
            ),
          );

        return _listGrupoDeRestricao;
      }

      final response = await _getGrupoDeRestricaoListUsecase(search);
      _listGrupoDeRestricao
        ..clear()
        ..addAll(
          response.map(
            (e) => GrupoDeRestricaoState(
              grupoDeRestricao: e,
              deletarStore: DeletarGrupoDeRestricaoStore(_deletarGrupoDeRestricaoUsecase),
            ),
          ),
        );

      return _listGrupoDeRestricao;
    }, delay: delay);
  }

  Future<void> deleteGrupoDeRestricao(String id) async {
    _listGrupoDeRestricao.removeWhere((element) => element.grupoDeRestricao.id == id);

    update(_listGrupoDeRestricao, force: true);
  }
}
