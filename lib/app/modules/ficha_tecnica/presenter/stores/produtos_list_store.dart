// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/entities/produto.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_produtos_usecase.dart';

class ProdutoListStore extends NasajonStreamStore<List<ProdutoEntity>> {
  final GetTodosProdutosUsecase _getTodosProdutosUsecase;

  ProdutoListStore(
    this._getTodosProdutosUsecase,
  ) : super(initialState: []);

  @override
  void initStore() {
    super.initStore();

    getListProduto(delay: Duration.zero);
  }

  final _searchNotifier = RxNotifier<String>('');
  String get search => _searchNotifier.value;
  set search(String value) => _searchNotifier.value = value;

  Future<void> getListProduto({Duration delay = const Duration(milliseconds: 500), String search = ''}) async {
    setLoading(true);
    try {
      return execute(() async {
        return await _getTodosProdutosUsecase(search);
      }, delay: delay);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
