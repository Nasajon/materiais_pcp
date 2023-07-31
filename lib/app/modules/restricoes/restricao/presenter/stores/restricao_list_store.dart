import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/delete_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_list_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/state/restricao_state.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/presenter/stores/deletar_restricao_store.dart';

class RestricaoListStore extends NasajonStreamStore<List<RestricaoState>> {
  final GetListRestricaoUsecase _getListRestricaoUsecase;
  final DeleteRestricaoUsecase _deleteRestricaoUsecase;

  RestricaoListStore(
    this._getListRestricaoUsecase,
    this._deleteRestricaoUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListRestricao(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  final List<RestricaoState> _listRestricao = [];

  Future<void> getListRestricao({Duration delay = const Duration(milliseconds: 500)}) async {
    setLoading(true);

    try {
      execute(() async {
        final response = await _getListRestricaoUsecase(search);

        _listRestricao
          ..clear()
          ..addAll(response
              .map((restricao) => RestricaoState(
                    restricao: restricao,
                    deletarStore: DeletarRestricaoStore(_deleteRestricaoUsecase),
                  ))
              .toList());

        return _listRestricao;
      });
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<void> deleteRestricao(String id) async {
    _listRestricao.removeWhere((element) => element.restricao.id == id);

    update(_listRestricao, force: true);
  }
}
