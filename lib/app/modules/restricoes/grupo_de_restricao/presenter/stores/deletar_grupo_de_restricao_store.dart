import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/deletar_grupo_restricao_usecase.dart';

class DeletarGrupoDeRestricaoStore extends NasajonStreamStore<bool> {
  final DeletarGrupoDeRestricaoUsecase _deletarGrupoDeRestricaoUsecase;

  DeletarGrupoDeRestricaoStore(this._deletarGrupoDeRestricaoUsecase) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await _deletarGrupoDeRestricaoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
