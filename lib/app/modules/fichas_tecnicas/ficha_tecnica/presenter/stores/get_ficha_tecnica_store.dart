import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/fichas_tecnicas/ficha_tecnica/domain/usecases/get_ficha_tecnica_por_id_usecase.dart';

class GetFichaTecnicaPorIdStore extends NasajonStreamStore<FichaTecnicaAggregate?> {
  final GetFichaTecnicaPorIdUsecase _getFichaTecnicaPorIdUsecase;

  GetFichaTecnicaPorIdStore(this._getFichaTecnicaPorIdUsecase) : super(initialState: null);

  Future<void> getFichaTecnicaPorId(String fichaTecnicaId) async {
    setLoading(true, force: true);

    try {
      final response = await _getFichaTecnicaPorIdUsecase(fichaTecnicaId);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
