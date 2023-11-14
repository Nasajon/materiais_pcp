import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/deletar_turno_trabalho_usecase.dart';

class DeletarTurnoTrabalhoStore extends NasajonStreamStore<bool> {
  final DeletarTurnoTrabalhoUsecase deletarTurnoTrabalhoUsecase;

  DeletarTurnoTrabalhoStore(
    this.deletarTurnoTrabalhoUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(Duration(seconds: 3));
      final response = await deletarTurnoTrabalhoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
