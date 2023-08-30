// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/unidade_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_unidade_usecase.dart';

class GetUnidadeStore extends NasajonNotifierStore<List<UnidadeEntity>> {
  final GetUnidadeUsecase _getUnidadeUsecase;

  GetUnidadeStore(this._getUnidadeUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getUnidadeUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<UnidadeEntity>> getListUnidade({required search}) {
    return _getUnidadeUsecase(search);
  }
}
