// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/unidade.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todas_unidades_usecase.dart';

class UnidadeListStore extends NasajonStreamStore<List<UnidadeEntity>> {
  final GetTodasUnidadesUsecase _getTodasUnidadesUsecase;

  UnidadeListStore(
    this._getTodasUnidadesUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListUnidade(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  Future<void> getListUnidade({Duration delay = const Duration(milliseconds: 500), String search = ''}) async {
    setLoading(true);

    Future.delayed(delay);
    try {
      return execute(() async {
        return await _getTodasUnidadesUsecase(search);
      });
    } on Failure catch (e) {
      setError(e);
    }
  }
}
