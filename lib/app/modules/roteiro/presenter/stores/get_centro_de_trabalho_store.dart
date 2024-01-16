// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/centro_de_trabalho_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_centro_de_trabalho_usecase.dart';

class GetCentroDeTrabalhoStore extends NasajonNotifierStore<List<CentroDeTrabalhoEntity>> {
  final GetCentroDeTrabalhoUsecase _getCentroDeTrabalhoUsecase;

  GetCentroDeTrabalhoStore(this._getCentroDeTrabalhoUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getCentroDeTrabalhoUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<CentroDeTrabalhoEntity>> getListCentroDeTrabalho({required search}) async {
    return _getCentroDeTrabalhoUsecase(search);
  }
}
