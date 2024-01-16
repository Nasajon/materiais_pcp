import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/usecases/delete_grupo_de_recurso.dart';

class DeletarGrupoDeRecursoStore extends NasajonStreamStore<bool> {
  final DeleteGrupoDeRecursoUsecase deletarGrupoDeRecursoUsecase;

  DeletarGrupoDeRecursoStore(
    this.deletarGrupoDeRecursoUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(Duration(seconds: 3));
      final response = await deletarGrupoDeRecursoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
