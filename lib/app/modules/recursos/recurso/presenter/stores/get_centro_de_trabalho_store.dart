import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso_centro_de_trabalho.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/usecases/get_centro_de_trabalho_usecase.dart';

class GetCentroDeTrabalhoStore extends NasajonStreamStore<List<RecursoCentroDeTrabalho>> {
  final GetCentroDeTrabalhoUsecase _getCentroDeTrabalhoUsecase;

  GetCentroDeTrabalhoStore(this._getCentroDeTrabalhoUsecase) : super(initialState: []);

  Future<void> getCentrosDeTrabalho() async {
    setLoading(true);

    try {
      final response = await _getCentroDeTrabalhoUsecase();

      update(response);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
