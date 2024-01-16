import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/entities/restricao_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/restricao/domain/usecases/get_centro_de_trabalho_usecase.dart';

class GetCentroDeTrabalhoStore extends NasajonStreamStore<List<RestricaoCentroDeTrabalho>> {
  final GetCentroDeTrabalhoUsecase _getCentroDeTrabalhoUsecase;

  GetCentroDeTrabalhoStore(this._getCentroDeTrabalhoUsecase) : super(initialState: []);

  Future<void> getCentrosDeTrabalho(String search) async {
    setLoading(true);

    try {
      final response = await _getCentroDeTrabalhoUsecase(search: search);

      update(response);
    } on Failure catch (e) {
      setError(e);
    }
  }

  Future<List<RestricaoCentroDeTrabalho>> getCentro(String search, {String? ultimoCentroDeTrabalhoId}) async {
    final response = await _getCentroDeTrabalhoUsecase(search: search, ultimoCentroDeTrabalhoId: ultimoCentroDeTrabalhoId);
    return response;
  }
}
