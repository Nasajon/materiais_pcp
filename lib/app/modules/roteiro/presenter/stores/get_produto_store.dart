// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/produto_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_produto_usecase.dart';

class GetProdutoStore extends NasajonNotifierStore<List<ProdutoEntity>> {
  final GetProdutoUsecase _getProdutoUsecase;

  GetProdutoStore(this._getProdutoUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    setLoading(true);
    execute(() async {
      final response = await _getProdutoUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<ProdutoEntity>> getListProdutos({required search}) {
    return _getProdutoUsecase(search);
  }
}
