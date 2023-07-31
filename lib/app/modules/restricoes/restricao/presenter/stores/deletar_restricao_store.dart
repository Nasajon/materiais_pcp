import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricao/domain/usecases/delete_restricao_usecase.dart';

class DeletarRestricaoStore extends NasajonStreamStore<bool> {
  final DeleteRestricaoUsecase deleteRestricaoUsecase;

  DeletarRestricaoStore(
    this.deleteRestricaoUsecase,
  ) : super(initialState: false);

  String id = '';

  Future<void> deletar(String id) async {
    this.id = id;
    setLoading(true, force: true);

    try {
      await Future.delayed(Duration(seconds: 3));
      final response = await deleteRestricaoUsecase(id);

      update(response, force: true);
      this.id = '';
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }
}
