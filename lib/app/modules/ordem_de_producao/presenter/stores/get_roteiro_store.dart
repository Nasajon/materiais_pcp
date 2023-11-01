// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/entities/roteiro_entity.dart';
import 'package:pcp_flutter/app/modules/ordem_de_producao/domain/usecases/get_roteiro_usecase.dart';

class GetRoteiroStore extends NasajonNotifierStore<List<RoteiroEntity>> {
  final GetRoteiroUsecase _getRoteiroUsecase;

  GetRoteiroStore(this._getRoteiroUsecase) : super(initialState: []);

  void getList({required String produtoId, required search, Duration delay = const Duration(milliseconds: 500)}) {
    setLoading(true);
    execute(() async {
      final response = await _getRoteiroUsecase(produtoId, search: search);

      return response;
    }, delay: delay);
  }

  Future<List<RoteiroEntity>> getListRoteiros({required String produtoId, required search}) {
    return _getRoteiroUsecase(produtoId, search: search);
  }

  Future<List<RoteiroEntity>> getListRoteirosProximaPage({required String produtoId, required search, required String ultimoId}) {
    return _getRoteiroUsecase(produtoId, search: search, ultimoId: ultimoId);
  }
}
