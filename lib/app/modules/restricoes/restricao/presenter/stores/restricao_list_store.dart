import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/aggregates/restricao_aggregate.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/get_list_restricao_usecase.dart';

class RestricaoListStore extends NasajonStreamStore<List<RestricaoAggregate>> {
  final GetListRestricaoUsecase _getListRestricaoUsecase;

  RestricaoListStore(this._getListRestricaoUsecase) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListRestricao(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  Future<void> getListRestricao({Duration delay = const Duration(milliseconds: 500)}) async {
    setLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      execute(() async {
        return await _getListRestricaoUsecase(search);
      });
    } on Failure catch (e) {
      setError(e);
    }
  }
}
