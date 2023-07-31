import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/usecases/delete_recurso_usecase.dart';

class DeletarRecursoStore extends NasajonStreamStore<bool> {
  final DeleteRecursoUsecase deletarRecursoUsecase;

  DeletarRecursoStore(
    this.deletarRecursoUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(Duration(seconds: 3));
      final response = await deletarRecursoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
