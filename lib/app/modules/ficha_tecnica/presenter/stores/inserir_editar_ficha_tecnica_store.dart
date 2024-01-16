import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/aggreagates/ficha_tecnica_aggregate.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/atualizar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/inserir_ficha_tecnica_usecase.dart';

class InserirEditarFichaTecnicaStore extends NasajonStreamStore<FichaTecnicaAggregate?> {
  final InserirFichaTecnicaUsecase _inserirFichaTecnicaUsecase;
  final AtualizarFichaTecnicaUsecase _editarFichaTecnicaUsecase;
  final GetFichaTecnicaPorIdUsecase _getFichaTecnicaPorIdUsecase;

  InserirEditarFichaTecnicaStore(
    this._inserirFichaTecnicaUsecase,
    this._editarFichaTecnicaUsecase,
    this._getFichaTecnicaPorIdUsecase,
  ) : super(initialState: null);

  Future<void> adicionarFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    setLoading(true, force: true);

    try {
      final response = await _inserirFichaTecnicaUsecase(fichaTecnica);

      update(response, force: true);
    } on Failure catch (e) {
      setError(e, force: true);
    }

    setLoading(false, force: true);
  }

  Future<void> editarFichaTecnica(FichaTecnicaAggregate fichaTecnica) async {
    setLoading(true, force: true);

    try {
      final response = await _editarFichaTecnicaUsecase(fichaTecnica);

      if (response) {
        update(fichaTecnica, force: true);
      }
    } on Failure catch (error) {
      setError(error, force: true);
    }

    setLoading(false, force: true);
  }

  Future<FichaTecnicaAggregate?> getFichaTecnicaPorId(String fichaTecnicaId) async {
    try {
      return await _getFichaTecnicaPorIdUsecase(fichaTecnicaId);
    } on Failure catch (e) {
      setError(e);
      return null;
    }
  }
}
