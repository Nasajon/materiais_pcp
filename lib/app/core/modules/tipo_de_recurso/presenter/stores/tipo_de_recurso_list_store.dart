import 'package:flutter_core/ana_core.dart';

import '../../domain/entities/tipo_de_recurso.dart';
import '../../domain/usecases/get_tipo_de_recurso_list_usecase.dart';

class TipoDeRecursoListStore extends NasajonStreamStore<List<TipoDeRecurso>> {
  final GetTipoDeRecursoListUsecase _getTipoDeRecursoListUsecase;

  TipoDeRecursoListStore(this._getTipoDeRecursoListUsecase)
      : super(initialState: _getTipoDeRecursoListUsecase());
}
