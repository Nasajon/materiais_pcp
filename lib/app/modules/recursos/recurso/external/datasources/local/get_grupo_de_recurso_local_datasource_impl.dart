import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/modules/recursos/common/domain/entities/grupo_de_recurso.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/local/local_grupo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/common/external/mapper/local/local_tipo_de_recurso_mapper.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/infra/datasources/local/get_grupo_de_recurso_local_datasource.dart';

class GetGrupoDeRecursoLocalDatasourceImpl implements GetGrupoDeRecursoLocalDatasource {
  final Database _database;

  GetGrupoDeRecursoLocalDatasourceImpl(this._database) {
    Hive
      ..resetAdapters()
      ..registerAdapter(LocalGrupoDeRecursoMapper())
      ..registerAdapter(LocalTipoDeRecursoMapper());
  }

  @override
  Future<List<GrupoDeRecurso>> getList() async {
    final decisions = await _database.get<List?>(LocalDBKeys.grupoDeRecursoKey);

    if (decisions == null) return <GrupoDeRecurso>[];

    final listGrupoDeRecurso = List<GrupoDeRecurso>.from(decisions);

    return listGrupoDeRecurso;
  }
}
