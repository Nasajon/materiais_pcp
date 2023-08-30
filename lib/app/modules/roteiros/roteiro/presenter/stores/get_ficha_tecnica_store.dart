// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/entities/ficha_tecnica_entity.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_ficha_tecnica_usecase.dart';

class GetFichaTecnicaStore extends NasajonNotifierStore<List<FichaTecnicaEntity>> {
  final GetFichaTecnicaUsecase _getFichaTecnicaUsecase;

  GetFichaTecnicaStore(this._getFichaTecnicaUsecase) : super(initialState: []);

  void getList({required search, Duration delay = const Duration(milliseconds: 500)}) {
    execute(() async {
      final response = await _getFichaTecnicaUsecase(search);

      return response;
    }, delay: delay);
  }

  Future<List<FichaTecnicaEntity>> getListFichaTecnica({required search}) {
    return _getFichaTecnicaUsecase(search);
  }
}
