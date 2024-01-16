import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/entities/material_entity.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/errors/roteiro_failure.dart';
import 'package:pcp_flutter/app/modules/roteiro/domain/usecases/get_material_usecase.dart';

class GetMaterialStore extends NasajonNotifierStore<List<MaterialEntity>> {
  final GetMaterialUsecase _getMaterialUsecase;

  GetMaterialStore(this._getMaterialUsecase) : super(initialState: []);

  Future<void> getMateriais(String fichaTecnicaId) async {
    setLoading(true);
    try {
      final response = await _getMaterialUsecase(fichaTecnicaId);
      update(response);
    } on RoteiroFailure catch (failure) {
      setError(failure);
    } finally {
      setLoading(false);
    }
  }
}
