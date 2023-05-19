import 'package:flutter/foundation.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/repositories/get_grupo_de_recurso_repository.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/infra/datasources/local/get_grupo_de_recurso_local_datasource.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/infra/datasources/remote/get_grupo_de_recurso_datasource.dart';

class GetGrupoDeRecursoRepositoryImpl implements GetGrupoDeRecursoRepository {
  final GetGrupoDeRecursoDatasource _getGrupoDeRecursoDatasource;
  final GetGrupoDeRecursoLocalDatasource _getGrupoDeRecursoLocalDatasource;
  final InternetConnectionStore _connectionStore;

  GetGrupoDeRecursoRepositoryImpl(this._getGrupoDeRecursoDatasource, this._getGrupoDeRecursoLocalDatasource, this._connectionStore);

  @override
  Future<List<GrupoDeRecurso>> getList() {
    if (kIsWeb || _connectionStore.isOnline) {
      return _getGrupoDeRecursoDatasource.getList();
    }

    return _getGrupoDeRecursoLocalDatasource.getList();
  }
}
