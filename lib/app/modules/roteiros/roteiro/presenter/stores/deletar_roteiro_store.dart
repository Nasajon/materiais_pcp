import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/deletar_roteiro_usecase.dart';

class DeletarRoteiroStore extends NasajonStreamStore<bool> {
  final DeletarRoteiroUsecase _deletarRoteiroUsecase;
  DeletarRoteiroStore(this._deletarRoteiroUsecase) : super(initialState: false);

  Future<void> deletarRoteiroPorId(String id) async {
    setLoading(true);
    try {
      await _deletarRoteiroUsecase(id);
      update(true, force: true);
    } on RoteiroFailure catch (error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }
}
