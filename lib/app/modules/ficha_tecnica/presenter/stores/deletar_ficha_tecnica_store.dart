import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/deletar_ficha_tecnica_usecase.dart';

class DeletarFichaTecnicaStore extends NasajonStreamStore<bool> {
  final DeletarFichaTecnicaUsecase deletarFichaTecnicaUsecase;

  DeletarFichaTecnicaStore(
    this.deletarFichaTecnicaUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id, {Duration delay = const Duration(milliseconds: 500)}) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(delay);
      final response = await deletarFichaTecnicaUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
