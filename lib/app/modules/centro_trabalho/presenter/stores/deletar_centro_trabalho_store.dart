import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';

class DeletarCentroTrabalhoStore extends NasajonStreamStore<bool> {
  final DeletarCentroTrabalhoUsecase deletarCentroTrabalhoUsecase;

  DeletarCentroTrabalhoStore(
    this.deletarCentroTrabalhoUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(Duration(seconds: 3));
      final response = await deletarCentroTrabalhoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
